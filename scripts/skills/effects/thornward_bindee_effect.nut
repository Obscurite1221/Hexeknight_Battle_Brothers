this.thornward_bindee_effect <- this.inherit("scripts/skills/skill", {
    m = {
		Binder = null,
		Color = this.createColor("#ffffff"),
		IsActivated = false,
        Magnitude = null
	},

    function activate()
	{
		this.m.IsActivated = true;
	}

	function setMagnitude( _Magnitude )
	{
		this.m.Magnitude = _Magnitude;
	}

    function setBinder( _p )
	{
		if (_p == null)
		{
			this.m.Binder = null;
		}
		else if (typeof _p == "instance")
		{
			this.m.Binder = _p;
		}
		else
		{
			this.m.Binder = this.WeakTableRef(_p);
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
		this.m.ID = "effects.thornward_bindee";
		this.m.Name = "Thornward Binding";
		this.m.KilledString = "The sympathetic thornward crumbles upon death.";
		this.m.Icon = "skills/status_effect_84.png";
		this.m.IconMini = "status_effect_84_mini";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/hexe_hex_damage_01.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_02.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_03.wav",
			"sounds/enemies/dlc2/hexe_hex_damage_04.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

    function getDescription()
	{
		return "This character is being protected by another through sympathetic magic.\n" + "Redirecting [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Magnitude * 100 + "%[/color] of damage recieved.";
	}

    function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

        local inverse = 1.0 - this.m.Magnitude;
        local sumDamage = _hitInfo.DamageRegular;
		_properties.DamageReceivedRegularMult *= inverse;
		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.m.Binder.getRef()) + " redirected " + (sumDamage * this.m.Magnitude).tointeger() + " damage back due to thornward.");
		this.m.Binder.applyDamage(sumDamage * this.m.Magnitude, _attacker);
	}

    function onRemoved()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("status_hex"))
		{
			actor.getSprite("status_hex").Visible = false;
			actor.getSprite("status_hex").Color = this.createColor("#ffffff");
		}

		actor.setDirty(true);

		if (this.m.Binder != null && !this.m.Binder.isNull() && !this.m.Binder.getContainer().isNull())
		{
			local binder = this.m.Binder;
			this.m.Binder = null;
			binder.setBindee(null);
			binder.removeSelf();
			binder.getContainer().update();
		}
	}

    function onDeath( _fatalityType )
	{
		this.onRemoved();
	}

    function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (this.m.IsActivated && (this.m.Binder == null || this.m.Binder.isNull() || !this.m.Binder.isAlive()))
		{
			this.removeSelf();
		}
		else if (actor.hasSprite("status_hex"))
		{
			local hex = actor.getSprite("status_hex");
			local fadeIn = !hex.Visible;

			if (fadeIn)
			{
				hex.setBrush("bust_hex_sw");
				hex.Color = this.m.Color;
				hex.Alpha = 0;
				hex.Visible = true;
				hex.fadeIn(700);
				actor.setDirty(true);
			}
		}
	}
})