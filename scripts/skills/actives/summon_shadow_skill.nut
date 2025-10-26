this.summon_shadow_skill <- this.inherit("scripts/skills/skill", {
    m = {
        currently_summoned = 0,
		cooldown = 1,
		hpcost = 5
    },
    function create() {
        this.m.ID = "actives.summon_shadow";
        this.m.Name = "Summon Shadow";
		this.m.Description = "";
		this.m.Icon = "skills/hex_square.png";
		this.m.IconDisabled = "skills/hex_square_bw.png";
		this.m.Overlay = "active_160";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/alp_nightmare_01.wav",
			"sounds/enemies/dlc2/alp_nightmare_02.wav",
			"sounds/enemies/dlc2/alp_nightmare_03.wav",
			"sounds/enemies/dlc2/alp_nightmare_04.wav",
			"sounds/enemies/dlc2/alp_nightmare_05.wav",
			"sounds/enemies/dlc2/alp_nightmare_06.wav"
		];
		this.m.IsUsingActorPitch = true;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 400;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsUsingHitchance = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 4;
    }

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString() + "\nCurrent Hitpoint Cost: " + this.m.hpcost + "\nCurrent # of Puppets: " + this.m.currently_summoned
			}
		];

		return ret;
	}

    function isUsable()
	{
		if (this.m.currently_summoned > 1)
		{
			return false;
		}
		if (this.m.cooldown > 0)
		{
			return false;
		}

		return true;
	}

	function onTurnStart()
	{
		this.m.cooldown = this.Math.max(0, this.m.cooldown - 1);
	}

    function onUse( _user, _targetTile )
	{
		local tag = {
			User = _user,
			TargetTile = _targetTile
		};
		local num = 1;

		for (local i = 0; i < num; ++i)
		{

			//this.Time.scheduleEvent(this.TimeUnit.Virtual, 100 * i, function(_a) {
				local nightmare = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/hexeknight_shadow_summon", _targetTile.Coords.X, _targetTile.Coords.Y);
				nightmare.setFaction(this.Const.Faction.PlayerAnimals);
				nightmare.spawnSpecialEffect(_targetTile);
				nightmare.assignRandomEquipment();
				nightmare.setMaster(_user);
				nightmare.setResolve(_user.getBravery());
				nightmare.setRef(this);
			//}.bindenv(this), _user);
		}

		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " bends the watching shadows to their aid!");

		this.onDelayedEffect(tag.User);
		this.m.currently_summoned += 1;
		this.m.cooldown += 1;
		this.m.hpcost += 3;
		return true;
	}

	function minionDeath() {
		this.m.currently_summoned = this.Math.max(0, this.m.currently_summoned - 1);
	}

	function onBattleWon() {
		this.m.currently_summoned = 0;
		this.m.hpcost = 5;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
        if (_targetTile.IsOccupiedByActor)
		{
			return false;
		}
        return _targetTile.IsEmpty;
	}

	function onDelayedEffect( _user )
	{
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = this.m.hpcost;
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		_user.onDamageReceived(_user, this, hitInfo);
	}

});