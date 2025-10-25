this.perk_through_pain_power <- this.inherit("scripts/skills/skill", {
    m = {},
    function create() {
        this.m.ID = "perk.through_pain_power";
        this.m.Name = ::Const.Strings.PerkName.through_pain_power;
        this.m.Description = ::Const.Strings.PerkDescription.through_pain_power;
        this.m.Icon = "ui/perks/perk_37.png"
        this.m.IconDisabled = "ui/perks/perk_37_sw.png"
        this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
        this.m.Order = this.Const.SkillOrder.Perk;
        this.m.IsActive = false;
        this.m.IsStacking = false;
        this.m.IsHidden = false;
    }

    function getTooltip() {
        local tooltip = this.skill.getTooltip();
        tooltip.push({
            id = 6,
            type = "text",
            icon = "ui/icons/fatigue.png",
            text = "• Gain 0.5% increased max hitpoints per point of resolve.\nCurrent: [color=" + this.Const.UI.Color.PositiveValue + "]" + (getBonus() - 1.0) * 100 + "[/color]%"
        })
        return tooltip;
    }

    function getBonus() {
        local bonus = this.getContainer().getActor().getBravery();
        local hpBoost = 1.0 + (0.005 * bonus);
        return hpBoost;
    }

    function getUnactivatedPerkTooltipHints()
	{
		return [{
            id = 6,
            type = "text",
            icon = "ui/icons/fatigue.png",
            text = "• [color=" + this.Const.UI.Color.PositiveValue + "]" + (getBonus() - 1.0) * 100 + "[/color]% bonus hitpoints."
        }];
	}

    function onAdded()
	{
		local actor = this.getContainer().getActor();

		if (actor.getHitpoints() == actor.getHitpointsMax())
		{
			actor.setHitpoints(this.Math.floor(actor.getHitpoints() * getBonus()));
		}
	}

    function onUpdate( _properties )
	{
		_properties.HitpointsMult *= getBonus();
	}
})