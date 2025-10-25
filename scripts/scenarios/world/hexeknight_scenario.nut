this.hexeknight_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
    m = {},
    function create() {
        this.m.ID = "scenario.hexeknight";
        this.m.Name = "Hexeknight";
        this.m.Description = "[p=c][img]gfx/ui/events/event_35.png[/img][/p][p]Your every movement is a reminder of the nightmarish rituals that Hexen cast on you. Fortunately, you saw your moment and ran without looking back, swearing that you would one day return to enact vengeance.\n\n[color=#bcad8c]Hexen Magic:[/color] You have gained a strange, unpleasant form of power as a result of your tortured past.\n[color=#bcad8c]Avatar:[/color] If you die, it is game over.[/p]";
        this.m.Difficulty = 3;
        this.m.Order = 129;
        this.m.IsFixedLook = true;
        this.m.StartingRosterTier = this.Const.Roster.getTierForSize(3);
        this.m.StartingBusinessReputation = 500;
        this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
    }

    function onSpawnAssets() {
        local roster = this.World.getPlayerRoster();
        local bro = roster.create("scripts/entity/tactical/player");
        bro.m.HireTime = this.Time.getVirtualTimeF();
		bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"hexeknight_hexeknight_background"
		]);

        bros[0].getBackground().buildDescription(true);
		bros[0].setTitle("the Hexeknight");
        ::Legends.Traits.grant(bros[0], ::Legends.Trait.Player);
        bros[0].getSkills().add(this.new("scripts/skills/perks/perk_malevolent_aura"));
		bros[0].getSkills().add(this.new("scripts/skills/injury_permanent/legend_scarred_injury"))
		//bros[0].getSkills().update();
        bros[0].setPlaceInFormation(4);
        bros[0].getFlags().set("IsPlayerCharacter", true);
        bros[0].getSprite("miniboss").setBrush("bust_miniboss_lone_wolf");
        bros[0].m.HireTime = this.Time.getVirtualTimeF();
        bros[0].m.PerkPoints = 3;
		bros[0].m.LevelUps = 3;
		bros[0].m.Level = 4;
        bros[0].setVeteranPerks(2);
        bros[0].m.Talents = [];
		bros[0].m.Attributes = [];
        local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
        talents[this.Const.Attributes.Bravery] = 3;
        talents[this.Const.Attributes.MeleeSkill] = 1;
        talents[this.Const.Attributes.Hitpoints] = 3;
        bros[0].fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
        this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
        this.World.Flags.set("HasLegendCampTraining", true);
        this.World.Assets.getStash().add(this.new("scripts/items/supplies/smoked_ham_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money / 3 - (this.World.Assets.getEconomicDifficulty() == 0 ? 0 : 100);
		this.World.Assets.m.ArmorParts = this.World.Assets.m.ArmorParts / 2;
		this.World.Assets.m.Medicine = this.World.Assets.m.Medicine / 3;
		this.World.Assets.m.Ammo = 0;
    }

    function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isIsolatedFromRoads() && !randomVillage.isSouthern())
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
        local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 4), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 4));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 4), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 4));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
                local tile = this.World.getTileSquare(x, y);
				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) == 0)
				{
				}
				else if (!tile.HasRoad)
				{
				}
				else
				{
					randomVillageTile = tile;
					break;
				}
			}
		}
		while (1);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(11);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		//this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		//{
		//	this.Music.setTrackList(this.Const.Music.IntroTracks, this.Const.Music.CrossFadeTime);
		//	this.World.Events.fire("event.anatomists_scenario_intro");
		//}, null);
	}
	
	function onCombatFinished()
	{
		local roster = this.World.getPlayerRoster().getAll();
		foreach( bro in roster )
		{
			if (bro.getFlags().get("IsPlayerCharacter"))
			{
				return true;
			}
		}
		return false;
	}
});