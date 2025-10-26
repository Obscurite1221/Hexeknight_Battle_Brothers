local activesDefs = [];
::Legends.Active.summon_shadow <- null;
activesDefs.push({
	ID = "actives.summon_shadow",
	Script = "scripts/skills/actives/summon_shadow_skill",
	Const = "summon_shadow_active",
	Name = "Conjure Shadow",
});
::Legends.Actives.addActiveDefObjects(activesDefs);

