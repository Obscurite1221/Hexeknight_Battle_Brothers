this.thornward_binder_effect <- this.inherit("scripts/skills/skill", {
    m = {
		Bindee = null,
		Color = this.createColor("#ffffff"),
		IsActivated = false,
		TurnsLeft = 3
	},
    function activate()
	{
		this.m.IsActivated = true;
	}

    function setBindee( _p )
	{
		if (_p == null)
		{
			this.m.Bindee = null;
		}
		else if (typeof _p == "instance")
		{
			this.m.Bindee = _p;
		}
		else
		{
			this.m.Bindee = this.WeakTableRef(_p);
		}
	}

    function setColor( _c )
	{
		this.m.Color = _c;
	}

    function isAlive()
	{
		return this.getContainer() != null && !this.getContainer().isNull() && this.getContainer().getActor() != null && !this.getContainer().getActor().isNull() && this.getContainer().getActor().isAlive() && this.getContainer().getActor().getHitpoints() > 0;
	}

    function create()
	{
		this.m.ID = "effects.thornward_binder";
		this.m.Name = "Thornward Source";
		this.m.Icon = "skills/status_effect_84.png";
		this.m.IconMini = "status_effect_84_mini";
		this.m.SoundOnUse = [
			"sounds/combat/poison_applied_01.wav",
			"sounds/combat/poison_applied_02.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

    function onUpdate( _properties )
	{
		if (this.m.IsActivated && (this.m.Bindee == null || this.m.Bindee.isNull() || !this.m.Bindee.isAlive()))
		{
			this.removeSelf();
		}
		else
		{
			local actor = this.getContainer().getActor();
			actor.getSprite("status_hex").setBrush("bust_hex_sw");
			actor.getSprite("status_hex").Color = this.m.Color;
			actor.getSprite("status_hex").Visible = true;
			actor.setDirty(true);
		}
	}

	function onTurnStart()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

    function onRemoved()
	{
		local actor = this.getContainer().getActor();
		actor.getSprite("status_hex").Visible = false;
		actor.getSprite("status_hex").Color = this.createColor("#ffffff");
		actor.setDirty(true);

		if (this.m.Bindee != null && !this.m.Bindee.isNull() && !this.m.Bindee.getContainer().isNull())
		{
			local bindee = this.m.Bindee;
			this.m.Bindee = null;
			bindee.setBinder(null);
			bindee.removeSelf();
			bindee.getContainer().update();
		}
	}

	function getRef()
	{
		return this.getContainer().getActor();
	}

	function applyDamage( _damage, _attacker)
	{
		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.25, this.getContainer().getActor().getPos());
		}
		this.Tactical.EventLog.log(_attacker.getID());
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = _damage;
		hitInfo.DamageArmor = _damage;
		hitInfo.DamageDirect = 0.1;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		this.Tactical.EventLog.log("Attempt reflect " + _damage + " damage. Entity " + _attacker.getID());
		this.getContainer().getActor().onDamageReceived(_attacker, null, hitInfo);
		
	}

	function onDeath( _fatalityType )
	{
		this.onRemoved();
	}
})