this.perk_summon_shadow <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.summon_shadow";
		this.m.Name = this.Const.Strings.PerkName.summon_shadow;
		this.m.Description = this.Const.Strings.PerkDescription.summon_shadow;
		this.m.Icon = "ui/perks/perk_37.png";
        this.m.IconDisabled = "ui/perks/perk_37.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.summon_shadow"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/summon_shadow_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.summon_shadow");
	}
});