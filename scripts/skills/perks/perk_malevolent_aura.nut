this.perk_malevolent_aura <- this.inherit("scripts/skills/skill", {
    m = {},
    function create() {
        this.m.ID = "perk.malevolent_aura";
        this.m.Name = ::Const.Strings.PerkName.malevolent_aura;
        this.m.Description = ::Const.Strings.PerkDescription.malevolent_aura;
        this.m.Icon = "ui/perks/perk_37.png";
        this.m.IconDisabled = "ui/perks/perk_37.png";
        this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
        this.m.Order = this.Const.SkillOrder.Perk;
        this.m.IsActive = false;
        this.m.IsStacking = false;
        this.m.IsHidden = false;
    }

    function getTooltip() {
        local tooltip = this.skill.getTooltip();
        local bonus = this.getBonus();
        local damageToHP = (0.1 * (1.0 + (getBonus() * 0.01)) * 100) - 10;
        local damageToArmor = 90 - damageToHP;
        local totalReflectAmp = (getBonus() * 0.01) * 100;
        tooltip.push({
            id = 6,
            type = "text",
            icon = "ui/icons/regular_damage.png",
            text = "Current Effect:\n" +
            "• [color=" + this.Const.UI.Color.PositiveValue + "]" + totalReflectAmp + "[/color]% of all damage reflected.\n(100% of Resolve)\n" +
            "• [color=" + this.Const.UI.Color.PositiveValue + "]10% + " + damageToHP + "[/color]% ignores armor.\n(10% of Resolve)\n" +
            "• [color=" + this.Const.UI.Color.PositiveValue + "]" + damageToArmor + "[/color]% damages armor."
        })

        return tooltip;
    }

    function getBonus()
    {
        local actor = this.getContainer().getActor();
        local resolve = actor.getCurrentProperties().getBravery();

        local bonus = resolve;
        return bonus;
    }

    function getUnactivatedPerkTooltipHints()
	{
		return [{
            id = 6,
            type = "text",
            icon = "ui/icons/fatigue.png",
            text = "• Reflect a percentage of [color=" + this.Const.UI.Color.PositiveValue + "]" +
            "all" + "[/color] damage recieved. " +
            "A small percentage of damage reflected will penetrate armor.\nAll effects scale with Resolve.\n\n" +
            "Current Effect:\n" +
            "• [color=" + this.Const.UI.Color.PositiveValue + "]" + totalReflectAmp + "[/color]% of all damage reflected.\n(100% of Resolve)\n" +
            "• [color=" + this.Const.UI.Color.PositiveValue + "]10% + " + damageToHP + "[/color]% ignores armor.\n(10% of Resolve)\n" +
            "• [color=" + this.Const.UI.Color.PositiveValue + "]" + damageToArmor + "[/color]% damages armor."
        }];
	}

    function onDamageReceived(_attacker, _damageHitpoints, _damageArmor) {

        local attacker = _attacker;
        //if (typeof attacker == "integer")
        //    { attacker = this.Tactical.getEntityByID(attacker); }
        if (attacker != null && attacker.isAlive() && attacker.getHitpoints() > 0 && attacker.getID() != this.getContainer().getActor().getID() && !attacker.getCurrentProperties().IsImmuneToDamageReflection) {
            local hitInfo = clone this.Const.Tactical.HitInfo;
            hitInfo.DamageRegular = (_damageHitpoints + _damageArmor) * (getBonus() * 0.01);
            hitInfo.DamageArmor = (_damageHitpoints + _damageArmor) * (getBonus() * 0.01) * (1.0 - (0.1 * (1.0 + (getBonus() * 0.01))));
            hitInfo.DamageDirect = 0.1 * (1.0 + (getBonus() * 0.01));
            hitInfo.BodyPart = this.Const.BodyPart.Body;
            hitInfo.BodyDamageMult = 1.0;
            hitInfo.FatalityChanceMult = 0.0;
            
            this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " reflected " + ((_damageHitpoints + _damageArmor) * (getBonus() * 0.01)) + " damage back to " + this.Const.UI.getColorizedEntityName(_attacker) + " due to their thorns.");

            attacker.onDamageReceived(_attacker, null, hitInfo);
        }
    }
})