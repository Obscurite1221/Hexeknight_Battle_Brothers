this.hexeknight_hexeknight_background <- this.inherit("scripts/skills/backgrounds/character_background", {
    m = {},
    function create() {
        this.character_background.create();
        this.m.ID = "background.hexeknight_hexeknight";
		this.m.Name = "Hexeknight";
		this.m.Icon = "ui/backgrounds/background_zombie.png";
		this.m.BackgroundDescription = "A product of horrific magic and profane rituals, a Hexeknight has had some of a Hexen's magic etched into their very flesh.";
		this.m.GoodEnding = "";
		this.m.BadEnding = "";
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;

        this.m.ExcludedTalents = [
			//this.Const.Attributes.RangedSkill,
			//this.Const.Attributes.Hitpoints,
			//this.Const.Attributes.Fatigue,
			//this.Const.Attributes.Bravery
		];

		this.m.Ethnicity = this.Math.rand(0, 2);
		if (this.m.Ethnicity == 0)
		{
			this.m.Bodies = this.Const.Bodies.Muscular;
			this.m.Faces = this.Const.Faces.AllWhiteMale;
			this.m.Hairs = this.Const.Hair.CommonMale;
			this.m.HairColors = this.Const.HairColors.All;
			this.m.Beards = this.Const.Beards.All;
			this.m.BeardChance = 60;
		}
		else if (this.m.Ethnicity == 1)
		{
			this.m.Bodies = this.Const.Bodies.Gladiator;
			this.m.Faces = this.Const.Faces.SouthernMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.Southern;
			this.m.Beards = this.Const.Beards.Southern;
			this.m.BeardChance = 60;
			this.m.Names = this.Const.Strings.SouthernNames;
			this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		}
		else if (this.m.Ethnicity == 2)
		{
			this.m.Bodies = this.Const.Bodies.AfricanGladiator;
			this.m.Faces = this.Const.Faces.AfricanMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.African;
			this.m.Beards = this.Const.Beards.Southern;
			this.m.BeardChance = 60;
			this.m.Names = this.Const.Strings.SouthernNames;
			this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		}

		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[3];

        this.m.BackgroundType = this.Const.BackgroundType.Outlaw;
        this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.PerkTreeDynamicMins.Weapon = 0;
		this.m.PerkTreeDynamicMins.Traits = 0;
		this.m.PerkTreeDynamicMins.Profession = 0;
		this.m.PerkTreeDynamicMins.Defense = 0;
		this.m.PerkTreeDynamicMins.Enemy = 0;
		this.m.PerkTreeDynamicMins.Magic = 0;
        this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.TwoHandedTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.FistsTree,
				this.Const.Perks.OneHandedTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.FitTree
			],
			Enemy = [
				//this.Const.Perks.HexenTree
			],
			Class = [
				this.Const.Perks.HexeknightClassTree
			],
			Profession = [],
			Magic = []
		}
    }

	function getTooltip()
	{
		return this.character_background.getTooltip();
	}


    function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.Names = this.Const.Strings.AncientDeadNamesFemale;
		// this.m.LastNames = this.Const.Strings.AncientDeadTitles;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function onBuildDescription()
	{
		return "{%fullname% is a product of horrific magic and profane rituals, a Hexen\'s magic etched into his very bones. | %fullname% can\'t remember the last time he could move without pain.}";
	}

    function onChangeAttributes() //uses Character_background.nut template (Skeleton)
	{
		local c = {
			Hitpoints = [
				3,
				6
			],
			Bravery = [ //not needed except for resisting charm and sleep
				5,
				10
			],
			Stamina = [ //not needed except for equipment weight
				0,
				5
			],
			MeleeSkill = [
				0,
				4
			],
			RangedSkill = [
				-8,
				-4
			],
			MeleeDefense = [
				-4,
				0
			],
			RangedDefense = [
				-4,
				0
			],
			Initiative = [
				-2,
				1
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 25)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

    function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/militia_spear"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/short_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/padded_surcoat"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/gambeson"));
		}

		r = this.Math.rand(0, 5);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/aketon_cap"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/full_aketon_cap"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/helmets/open_leather_cap"));
		}
	}
	

    function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
	}

})