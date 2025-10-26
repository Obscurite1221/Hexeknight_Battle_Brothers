::Mod_hexeknight <- {
    ID = "mod_hexeknight",
    Name = "Hexeknight",
    Version = "0.5.0",   
};

::Mod_hexeknight.HooksMod <- ::Hooks.register(::Mod_hexeknight.ID, ::Mod_hexeknight.Version, ::Mod_hexeknight.Name)

::Mod_hexeknight.HooksMod.require("mod_msu >= 1.2.6", "mod_modern_hooks >= 0.5.4", "mod_legends >= 19.0.0");

::Mod_hexeknight.HooksMod.queue(">mod_msu", ">mod_legends", ">mod_breditor", function() {

    ::Mod_hexeknight.Mod <- ::MSU.Class.Mod(::Mod_hexeknight.ID, ::Mod_hexeknight.Version, ::Mod_hexeknight.Name); 

    ::include("mod_Hexeknight/load.nut"); 

}, ::Hooks.QueueBucket.Normal);

