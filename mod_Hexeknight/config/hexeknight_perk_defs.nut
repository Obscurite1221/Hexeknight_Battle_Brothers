::Legends.Perk.malevolent_aura <- null;
::Legends.Perk.through_pain_power <- null;
::Legends.Perk.baleful_purpose <- null;
::Legends.Perk.thornward <- null;
::Const.Perks.addPerkDefObjects([
    {
        ID = "perk.malevolent_aura",
        Script = "scripts/skills/perks/perk_malevolent_aura",
        Name = ::Const.Strings.PerkName.malevolent_aura,
        Tooltip = ::Const.Strings.PerkDescription.malevolent_aura,
        Icon = "ui/perks/perk_37.png",
        IconDisabled = "ui/perks/perk_37_sw.png",
        Const = "malevolent_aura",
        HasUnactivatedPerkTooltipHints = true
    },
    {
        ID = "perk.through_pain_power",
        Script = "scripts/skills/perks/perk_through_pain_power",
        Name = ::Const.Strings.PerkName.through_pain_power,
        Tooltip = ::Const.Strings.PerkDescription.through_pain_power,
        Icon = "ui/perks/perk_37.png",
        IconDisabled = "ui/perks/perk_37_sw.png",
        Const = "through_pain_power",
        HasUnactivatedPerkTooltipHints = true
    },
    {
        ID = "perk.baleful_purpose",
        Script = "scripts/skills/perks/perk_baleful_purpose",
        Name = ::Const.Strings.PerkName.baleful_purpose,
        Tooltip = ::Const.Strings.PerkDescription.baleful_purpose,
        Icon = "ui/perks/perk_37.png",
        IconDisabled = "ui/perks/perk_37_sw.png",
        Const = "baleful_purpose",
        HasUnactivatedPerkTooltipHints = true
    },
    {
        ID = "perk.thornward",
        Script = "scripts/skills/perks/perk_thornward",
        Name = ::Const.Strings.PerkName.thornward,
        Tooltip = ::Const.Strings.PerkDescription.thornward,
        Icon = "ui/perks/perk_37.png",
        IconDisabled = "ui/perks/perk_37_sw.png",
        Const = "thornward"
    }]);