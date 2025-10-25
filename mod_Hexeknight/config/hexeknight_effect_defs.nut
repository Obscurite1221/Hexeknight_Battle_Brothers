local effectsDefs = [];
::Legends.Effect.thornward_binder <- null;
effectsDefs.push({
	ID = "effects.thornward_binder",
	Script = "scripts/skills/effects/thornward_binder_effect",
	Name = "Thornward Source",
	Const = "thornward_binder"
});

::Legends.Effect.thornward_bindee <- null;
effectsDefs.push({
	ID = "effects.thornward_bindee",
	Script = "scripts/skills/effects/thornward_bindee_effect",
	Name = "Thornward Binding",
	Const = "thornward_bindee"
});
::Legends.Effects.addEffectDefObjects(effectsDefs)