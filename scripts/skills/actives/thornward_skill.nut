this.thornward_skill <- this.inherit("scripts/skills/skill", {
    m = { 
        Cooldown = 1,
        Binder = null
     },
    function create() {
        this.m.ID = "actives.thornward";
        this.m.Name = "Thornward";
        this.m.Description = "Channel the sympathetic magic of a Hexen to form a fleeting pact with an ally, taking upon thyself their suffering.";
        this.m.Icon = "skills/hex_square.png";
		this.m.IconDisabled = "skills/hex_square_bw.png";
		this.m.Overlay = "active_119";
        this.m.SoundOnHit = [
			"sounds/enemies/dlc2/hexe_hex_01.wav",
			"sounds/enemies/dlc2/hexe_hex_02.wav",
			"sounds/enemies/dlc2/hexe_hex_03.wav",
			"sounds/enemies/dlc2/hexe_hex_04.wav",
			"sounds/enemies/dlc2/hexe_hex_05.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/enemies/dlc2/hexe_hex_damage_01.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_02.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_03.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_04.wav"
		];
        this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 500;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsVisibleTileNeeded = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 1;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 8;
		this.m.MaxLevelDifference = 4;
    }

    function getTooltip()
	{
		local value = this.getContainer().getActor().getCurrentProperties().Bravery / 5;
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
				text = this.getCostString() + "Current Magnitude:" + value + "%"
			}
		];

		return ret;
	}

    function isUsable()
	{
		return this.m.Cooldown == 0 && this.skill.isUsable();
	}

    function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

        if (!_targetTile.IsOccupiedByActor)
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (target.getCurrentProperties().IsImmuneToDamageReflection)
		{
			return false;
		}

		local target = _targetTile.getEntity();
        if (!target.isAlliedWith(this.getContainer().getActor()))
		{
			return false;
		}

		return true;
	}

    function onTurnStart()
	{
		this.m.Cooldown = this.Math.max(0, this.m.Cooldown - 1);
	}

    function onUse( _user, _targetTile )
	{
		local tag = {
			User = _user,
			TargetTile = _targetTile
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onDelayedEffect.bindenv(this), tag);
		this.m.Cooldown = 1;
		return true;
	}

    function onDelayedEffect( _tag )
	{
		local _targetTile = _tag.TargetTile;
		local _user = _tag.User;
		local target = _targetTile.getEntity();

		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " wards " + this.Const.UI.getColorizedEntityName(target) + ", sharing their suffering.");

			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill * 1.0, _user.getPos());
			}
		}

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 800, function ( _tag )
		{
			local color;

            if (this.m.Binder != null) {
                this.m.Binder.removeSelf();
            }

			do
			{
				color = this.createColor("#ff0000");
				color.varyRGB(0.75, 0.75, 0.75);
			}
			while (color.R + color.G + color.B <= 150);

			this.Tactical.spawnSpriteEffect("effect_pentagram_02", color, _targetTile, !target.getSprite("status_hex").isFlippedHorizontally() ? 10 : -5, 88, 3.0, 1.0, 0, 400, 300);
			local bindee = this.new("scripts/skills/effects/thornward_bindee_effect");
			local binder = this.new("scripts/skills/effects/thornward_binder_effect");
			bindee.setBinder(binder);
			bindee.setColor(color);
			target.getSkills().add(bindee);
			binder.setBindee(bindee);
			binder.setColor(color);
            this.m.Binder = binder;
			_user.getSkills().add(binder);
            bindee.setMagnitude(_user.getBravery() / 500)
			bindee.activate();
			binder.activate();
		}.bindenv(this), null);
	}
})