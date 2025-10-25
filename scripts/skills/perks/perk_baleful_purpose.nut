this.perk_baleful_purpose <- this.inherit("scripts/skills/skill", {
    m = {},
    function create() {
        this.m.ID = "perk.baleful_purpose";
        this.m.Name = ::Const.Strings.PerkName.baleful_purpose;
        this.m.Description = ::Const.Strings.PerkDescription.baleful_purpose;
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

        tooltip.push({
            id = 6,
            type = "text",
            icon = "ui/icons/special.png",
            text = "• [color=" + this.Const.UI.Color.PositiveValue + "]" + (bonus - 1.0) * 100 + "[/color]% increase to Resolve."
        })

        return tooltip;
    }

    function getUnactivatedPerkTooltipHints()
	{
		return [{
            id = 6,
            type = "text",
            icon = "ui/icons/special.png",
            text = "• [color=" + this.Const.UI.Color.PositiveValue + "]" + (getBonus() - 1.0) * 100 + "[/color]% increase to Resolve."
        }];
	}

    function getBonus() {
        local actor = this.getContainer().getActor();
        local level = actor.getLevel();
        local bonus = 1.0 + (level * 0.03);
        return bonus;
    }

    function onUpdate( _properties )
	{
		_properties.BraveryMult *= getBonus();
	}
})