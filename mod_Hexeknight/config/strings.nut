if (!("Passive" in ::Const.UI.Color))
{
	::Const.UI.Color.Passive <- "#4f1800";
}

if (!("Active" in ::Const.UI.Color))
{
	::Const.UI.Color.Active <- "#000ec1";
}

if (!("OneTimeEffect" in ::Const.UI.Color))
{
	::Const.UI.Color.OneTimeEffect <- "#000ec1";
}

if (!("Status" in ::Const.UI.Color))
{
	::Const.UI.Color.Status <- "#731f39";
}

if (!("Skill" in ::Const.UI.Color))
{
	::Const.UI.Color.Skill <- "#400080";
}

if (!("Perk" in ::Const.UI.Color))
{
	::Const.UI.Color.Perk <- "#008060";
}

::Const.Strings.PerkName.malevolent_aura <- "Malevolent Aura";
::Const.Strings.PerkDescription.malevolent_aura <- ::Legends.tooltip(@"
An oppressive aura of dread radiates from you, reflecting whatever befalls you upon your enemies.
[color=%passive%][u]Passive:[/u][/color]
• Reflect a percentage of all damage recieved equal to [color=%positive%]100%[/color] of Resolve.
• A small percentage ([color=%positive%]10%[/color] of Resolve) will penetrate armor.
");

::Const.Strings.PerkName.through_pain_power <- "Through Pain, Power";
::Const.Strings.PerkDescription.through_pain_power <- ::Legends.tooltip(@"
Hexen magic thrives in suffering, providing unnatural resilience even as the body flags.
[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]0.5%[/color] max hitpoints per point of Resolve.
");

::Const.Strings.PerkName.baleful_purpose <- "Baleful Purpose";
::Const.Strings.PerkDescription.baleful_purpose <- ::Legends.tooltip(@"
As within, so without. A silent burden festers in this one's mind, filling them with terrible resolve.
[color=%passive%][u]Passive:[/u][/color]
• Gain [color=%positive%]3%[/color] Resolve per Character Level.
");

::Const.Strings.PerkName.thornward <- "Thornward";
::Const.Strings.PerkDescription.thornward <- ::Legends.tooltip(@"
Take upon yourself the suffering of another and lash back at their aggressors with inhuman rage.
[color=%passive%][u]Passive:[/u][/color]
• Unlocks the [color=%skill%]Thornward[/color] skill, allowing you to place a shield on an ally that redirects a percentage of all damage taken back to you.
• Damage redirected via [color=%skill%]Thornward[/color] also triggers [color=%skill%]Malevolent Aura[/color], reflecting damage back to the attacker.
• [color=%skill%]Thornward[/color] redirects a percentage equal to [color=%positive%]20%[/color] of the caster's Resolve.
• Costs [color=%negative%]1[/color] AP and [color=%negative%]10[/color] Fatigue
");

::Const.Strings.PerkName.summon_shadow <- "Summon Shadow";
::Const.Strings.PerkDescription.summon_shadow <- ::Legends.tooltip(@"
You flick a few drops of blood into the shadows around you, animating them into insubstantial yet dangerous forms.
[color=%passive%][u]Passive:[/u][/color]
• Unlocks the [color=%skill%]Summon Shadow[/color] skill, allowing you to summon up to two shadowy humanoids to assist you in combat.
• Shadow puppets also possess [color=%skill%]Aura of Malevolence[/color], letting them reflect whatever damage fells them.
• Shadow puppets grow more nimble and dangerous according to the caster's Resolve.
• Each successive puppet summoned costs 3 more hitpoints than the last.
• Costs [color=%negative%]3[/color] AP, [color=%negative%]30[/color] Fatigue, and [color=%negative%]variable[/color] Hitpoints.
");