this.perk_thornward <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.thornward";
		this.m.Name = this.Const.Strings.PerkName.thornward;
		this.m.Description = this.Const.Strings.PerkDescription.thornward;
		this.m.Icon = "ui/perks/perk_21.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.thornward"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/thornward_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.thornward");
	}

});