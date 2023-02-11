#priority 10
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.item.IIngredient;
import crafttweaker.api.registries.IRecipeManager;
import mods.jei.JEI;
import crafttweaker.api.recipe.Replacer;
import crafttweaker.api.item.tooltip.ITooltipFunction;
import crafttweaker.api.entity.Attribute;
import crafttweaker.api.Brewing;
import crafttweaker.api.potion.MCPotion;
import mods.mekanism.api.ingredient.ChemicalStackIngredient.SlurryStackIngredient;
import mods.mekanism.api.ingredient.FluidStackIngredient;
import mods.mekanism.api.ingredient.ChemicalStackIngredient.InfusionStackIngredient;
import mods.mekanism.api.ingredient.ItemStackIngredient;
import mods.mekanism.api.ingredient.ChemicalStackIngredient.GasStackIngredient;
import mods.botania.TerraPlate;
import mods.botania.ManaInfusion;
import mods.botania.RuneAltar;
import mods.botania.PetalApothecary;
import mods.eidolon.Worktable;
import mods.draconicevolution.TechLevel;
import mods.draconicevolution.FusionIngredient;
import crafttweaker.api.SmithingManager;
import crafttweaker.api.StoneCutterManager;
import crafttweaker.api.util.MCEquipmentSlotType;
import crafttweaker.api.entity.AttributeOperation;
import crafttweaker.api.entity.Attribute;

#shortcuts
    var air = <item:minecraft:air>;
    var ironPlate = <item:immersiveengineering:plate_iron>;
    var copperPlate = <item:immersiveengineering:plate_copper>;
    var aluminumPlate = <item:immersiveengineering:plate_aluminum>;
    var leadPlate = <item:immersiveengineering:plate_lead>;
    var silverPlate = <item:immersiveengineering:plate_silver>;
    var nickelPlate = <item:immersiveengineering:plate_nickel>;
    var uraniumPlate = <item:immersiveengineering:plate_uranium>;
    var constantanPlate = <item:immersiveengineering:plate_constantan>;
    var electrumPlate = <item:immersiveengineering:plate_electrum>;
    var steelPlate = <item:immersiveengineering:plate_steel>;
    var goldPlate = <item:immersiveengineering:plate_gold>;
    var netheritePlate = <item:thermal:netherite_plate>;
    var bronzePlate = <item:thermal:bronze_plate>;
    var tinPlate = <item:thermal:tin_plate>;
    var invarPlate = <item:thermal:invar_plate>;
    var signalumPlate = <item:thermal:signalum_plate>;
    var lumiumPlate = <item:thermal:lumium_plate>;
    var enderiumPlate = <item:thermal:enderium_plate>;
    var brassPlate = <item:create:brass_sheet>;
    var zincPlate = <item:createdeco:zinc_sheet>;
    var cylinder = <item:pneumaticcraft:pneumatic_cylinder>;
    var core = <item:lifesteal:heart_fragment>;
    var cob = <item:kubejs:compressed_obsidian>;
    var ech = <item:minecraft:ender_chest>;
    var csh = <item:draconicevolution:chaos_shard>;
    var ccc = <item:kubejs:chaotic_control_circuit>;
    var rec = <item:kubejs:reactor_core>;
    var redstone = <item:minecraft:redstone>;
function remove(input as IItemStack) as int {
    craftingTable.removeRecipe(input);
    mods.jei.JEI.hideItem(input);
    }
function removePotion(item as IItemStack, potion as MCPotion) as int {
    brewing.removeRecipeByOutputPotion(potion);
    mods.jei.JEI.hideItem(item);
    }
function removeMekanismProcessing(basename as string) as int {
    <recipetype:mekanism:washing>.removeByName("moremekanismprocessing:processing/" + basename + "/slurry/clean");
    <recipetype:mekanism:crystallizing>.removeByName("moremekanismprocessing:processing/" + basename + "/crystal/from_slurry");
    <recipetype:mekanism:injecting>.removeByName("moremekanismprocessing:processing/" + basename + "/shard/from_crystal");
    <recipetype:mekanism:purifying>.removeByName("moremekanismprocessing:processing/" + basename + "/clump/from_shard");
    <recipetype:mekanism:crushing>.removeByName("moremekanismprocessing:processing/" + basename + "/dirty_dust/from_clump");
    <recipetype:mekanism:enriching>.removeByName("moremekanismprocessing:processing/" + basename + "/dust/from_dirty_dust");
    mods.jei.JEI.hideItem(<item:moremekanismprocessing:crystal_${basename}>);
    mods.jei.JEI.hideItem(<item:moremekanismprocessing:shard_${basename}>);
    mods.jei.JEI.hideItem(<item:moremekanismprocessing:clump_${basename}>);
    mods.jei.JEI.hideItem(<item:moremekanismprocessing:dirty_dust_${basename}>);
    mods.jei.JEI.hideIngredient(<slurry:moremekanismprocessing:clean_${basename}>);
    mods.jei.JEI.hideIngredient(<slurry:moremekanismprocessing:dirty_${basename}>);
    }
function removeMekanismProcessingAll(basename as string, type as string) as int {
    removeMekanismProcessing(basename);
    if type == "ingot" {
        remove(<item:moremekanismprocessing:${basename}_ingot>);
        remove(<item:moremekanismprocessing:${basename}_nugget>);
        blastFurnace.removeRecipe(<item:moremekanismprocessing:${basename}_ingot>);
        furnace.removeRecipe(<item:moremekanismprocessing:${basename}_ingot>);
        <recipetype:mekanism:crushing>.removeByName("moremekanismprocessing:processing/" + basename + "/dust/from_ingot");
        mods.jei.JEI.hideItem(<item:moremekanismprocessing:dust_${basename}>);
    }
    else {
        remove(<item:moremekanismprocessing:gem_${basename}>);
        blastFurnace.removeRecipe(<item:moremekanismprocessing:gem_${basename}>);
        furnace.removeRecipe(<item:moremekanismprocessing:gem_${basename}>);
        <recipetype:mekanism:crushing>.removeByName("moremekanismprocessing:processing/" + basename + "/dust/from_gem");
        mods.jei.JEI.hideItem(<item:moremekanismprocessing:dust_${basename}>);
    }}
//remove(<item:>);
#minecraft/others
    #removals
        craftingTable.removeRecipe(<item:minecraft:enchanted_golden_apple>);
    #items
        #heart fragment
            mods.jei.JEI.addInfo(<item:lifesteal:heart_fragment>, ["Drops from heart ores, just as simple as that"]);
        #nether star
            craftingTable.addShaped("nether_star_edit", <item:minecraft:nether_star>, [
                [<item:minecraft:wither_skeleton_skull>, <item:minecraft:wither_skeleton_skull>, <item:minecraft:wither_skeleton_skull>],
                [<item:minecraft:soul_sand>, <item:minecraft:soul_sand>, <item:minecraft:soul_sand>],
                [<item:kubejs:omega_ingot>, <item:minecraft:soul_sand>, <item:kubejs:omega_ingot>]]);
        #comparator
            craftingTable.removeRecipe(<item:minecraft:comparator>);
            craftingTable.addShaped("comparator_edit", <item:minecraft:comparator>, [
                [air, <item:minecraft:redstone_torch>, air],
                [<item:minecraft:redstone_torch>, <item:thermal:quartz_gear>, <item:minecraft:redstone_torch>],
                [<tag:items:forge:stone>, <tag:items:forge:stone>, <tag:items:forge:stone>]]);
#botania recipes
    #items
        #benevolent charm
            craftingTable.removeRecipe(<item:botania:goddess_charm>);
            craftingTable.addShaped("benevolent_charm_edit", <item:botania:goddess_charm>, [
                [air, <tag:items:botania:petals/pink>, air],
                [air, <tag:items:botania:petals/pink>, air],
                [<item:botania:rune_water>, <item:botania:rune_pride>, <item:botania:rune_spring>]]);
        #livingwood avatar
            craftingTable.removeRecipe(<item:botania:avatar>);
            craftingTable.addShaped("livingwood_avatar_edit", <item:botania:avatar>, [
                [air, <item:botania:livingwood>, air],
                [<item:botania:livingwood>, <item:botania:dragonstone>, <item:botania:livingwood>],
                [<item:botania:livingwood>, air, <item:botania:livingwood>]]);
        #hells rod
            craftingTable.removeRecipe(<item:botania:fire_rod>);
            craftingTable.addShaped("rod_of_the_hells_edit", <item:botania:fire_rod>, [
                [air, <item:botania:rune_fire>, <item:minecraft:blaze_powder>],
                [<item:minecraft:blaze_rod>, <item:botania:livingwood_twig>, <item:botania:rune_fire>],
                [<item:botania:livingwood_twig>, <item:minecraft:blaze_rod>, air]]);
        #cirrus amulet
            craftingTable.removeRecipe(<item:botania:cloud_pendant>);
            craftingTable.addShaped("cirrus_amulet_edit", <item:botania:cloud_pendant>, [
                [<item:botania:rune_air>, <item:botania:mana_string>, <item:botania:manasteel_ingot>],
                [<item:botania:mana_string>, air, <item:botania:mana_string>],
                [<item:botania:manasteel_ingot>, <item:botania:mana_string>, <item:botania:rune_pride>]]);
        #crimson pendant
            craftingTable.removeRecipe(<item:botania:super_lava_pendant>);
            craftingTable.addShaped("crimson_pendant_edit", <item:botania:super_lava_pendant>, [
                [<item:minecraft:blaze_rod>, <item:minecraft:blaze_rod>, <item:minecraft:blaze_rod>],
                [<item:minecraft:blaze_rod>, <item:botania:lava_pendant>, <item:minecraft:blaze_rod>],
                [<item:minecraft:netherite_ingot>, <item:botania:life_essence>, <item:minecraft:netherite_ingot>]]);
        #pyroclast pendant
            craftingTable.removeRecipe(<item:botania:lava_pendant>);
            craftingTable.addShaped("pyroclast_pendant_edit", <item:botania:lava_pendant>, [
                [<item:botania:rune_fire>, <item:botania:mana_string>, <item:botania:manasteel_ingot>],
                [<item:botania:mana_string>, air, <item:botania:mana_string>],
                [<item:botania:manasteel_ingot>, <item:botania:mana_string>, <item:botania:rune_pride>]]);
        #Nimbus amulet
            craftingTable.removeRecipe(<item:botania:super_cloud_pendant>);
            craftingTable.addShaped("nimbus_amulet_edit", <item:botania:super_cloud_pendant>, [
                [<item:botania:manaweave_cloth>, <item:botania:elementium_ingot>, <item:botania:manaweave_cloth>],
                [<item:minecraft:nether_star>, <item:botania:cloud_pendant>, <item:minecraft:nether_star>],
                [<item:botania:life_essence>, <item:botania:rune_pride>, <item:botania:life_essence>]]);
        #globetrotter sash
            craftingTable.removeRecipe(<item:botania:super_travel_belt>);
            craftingTable.addShaped("super_travel_belt_edit", <item:botania:super_travel_belt>, [
                [<item:botania:elementium_ingot>, <item:botania:dragonstone>, <item:botania:rune_pride>],
                [<item:botania:pixie_dust>, <item:botania:travel_belt>, <item:botania:dragonstone>],
                [<item:botania:life_essence>, <item:botania:pixie_dust>, <item:botania:elementium_ingot>]]);
        #Terra shatterer
            craftingTable.removeRecipe(<item:botania:terra_pick>);
            craftingTable.addShaped("terra_shatterer", <item:botania:terra_pick>, [
                [<item:botania:terrasteel_block>, <item:botania:rune_mana>, <item:botania:terrasteel_block>],
                [<item:minecraft:air>, <item:botania:dreamwood_twig>, <item:minecraft:air>],
                [<item:minecraft:air>, <item:botania:rune_wrath>, <item:minecraft:air>]]);
        #Mana mirror
            craftingTable.removeRecipe(<item:botania:mana_mirror>);
            craftingTable.addShaped("mana_mirror", <item:botania:mana_mirror>, [
                [<item:minecraft:air>, <item:botania:terrasteel_ingot>, <item:botania:mana_tablet>],
                [<item:botania:rune_pride>, <item:botania:rune_mana>, <item:botania:terrasteel_ingot>],
                [<item:botania:livingwood_twig>, <item:botania:mana_pearl>, <item:minecraft:air>]]);
        #terrasteel plate
            craftingTable.removeRecipe(<item:botania:terra_plate>);
            craftingTable.addShaped("terra_plate_edit", <item:botania:terra_plate>, [
                [<item:minecraft:lapis_block>, <item:botania:spark>, <item:minecraft:lapis_block>],
                [<item:botania:rune_water>, <item:botania:manasteel_block>, <item:botania:rune_fire>],
                [<item:botania:rune_earth>, <item:botania:rune_mana>, <item:botania:rune_air>]]);
        #spark
            craftingTable.removeRecipe(<item:botania:spark>);
            craftingTable.addShaped("spark_edit", <item:botania:spark>, [
                [<item:minecraft:air>, <tag:items:botania:petals>, <item:minecraft:air>],
                [<item:minecraft:blaze_powder>, <item:botania:mana_pearl>, <item:minecraft:blaze_powder>],
                [<item:minecraft:air>, <tag:items:botania:petals>, <item:minecraft:air>]]);
    #flowers
        #rafflowsia
            <recipetype:botania:petal_apothecary>.removeRecipe(<item:botania:rafflowsia>);
            <recipetype:botania:petal_apothecary>.addRecipe("rafflowsia_edit", <item:botania:rafflowsia>, <tag:items:botania:petals/purple>, <tag:items:botania:petals/purple>, <tag:items:botania:petals/green>, <tag:items:botania:petals/green>, <tag:items:botania:petals/black>, <item:botania:rune_envy>, <item:botania:rune_earth>, <item:botania:pixie_dust>);
        #orechid
            <recipetype:botania:petal_apothecary>.removeRecipe(<item:botania:orechid>);
            <recipetype:botania:petal_apothecary>.addRecipe("orechid_edit", <item:botania:orechid>, <tag:items:botania:petals/gray>, <tag:items:botania:petals/gray>, <tag:items:botania:petals/yellow>, <tag:items:botania:petals/green>, <tag:items:botania:petals/red>, <item:botania:rune_pride>, <item:botania:rune_earth>, <item:botania:redstone_root>, <item:botania:pixie_dust>);
        #orechid ignem
            <recipetype:botania:petal_apothecary>.removeRecipe(<item:botania:orechid_ignem>);
            <recipetype:botania:petal_apothecary>.addRecipe("orechid_ignem_edit", <item:botania:orechid_ignem>, <tag:items:botania:petals/red>, <tag:items:botania:petals/red>, <tag:items:botania:petals/white>, <tag:items:botania:petals/white>, <tag:items:botania:petals/pink>, <item:botania:rune_pride>, <item:botania:rune_fire>, <item:botania:redstone_root>, <item:botania:pixie_dust>);
    #runecrafting
        #pride
            <recipetype:botania:runic_altar>.removeRecipe(<item:botania:rune_pride>);
            <recipetype:botania:runic_altar>.addRecipe("rune_pride_edit",  <item:botania:rune_pride>, 5000, <item:minecraft:netherite_ingot>, <item:botania:mana_diamond>, <item:botania:rune_envy>, <item:botania:rune_sloth>, <item:botania:mana_diamond>);
    #mana infusing
        #mana string
            <recipetype:botania:mana_infusion>.removeRecipe(<item:botania:mana_string>);
            <recipetype:botania:mana_infusion>.addRecipe("mana_string_edit", <item:botania:mana_string>, <item:minecraft:string>, 1000);
        #mana pearl
            <recipetype:botania:mana_infusion>.removeRecipe(<item:botania:mana_pearl>);
            <recipetype:botania:mana_infusion>.addRecipe("mana_pearl_edit", <item:botania:mana_pearl>, <item:minecraft:ender_pearl>, 7000);
        #manasteel
            <recipetype:botania:mana_infusion>.removeRecipe(<item:botania:manasteel_ingot>);
            <recipetype:botania:mana_infusion>.removeRecipe(<item:botania:manasteel_block>);
            <recipetype:botania:mana_infusion>.addRecipe("manasteel_edit", <item:botania:manasteel_ingot>, <item:minecraft:iron_block>, 1000);
    #terra plate
        #terrasteel
            <recipetype:botania:terra_plate>.removeRecipe(<item:botania:terrasteel_ingot>);
            <recipetype:botania:terra_plate>.addRecipe("terrsteel_edit", <item:botania:terrasteel_ingot>, 50000, <item:botania:mana_diamond>, <item:botania:manasteel_ingot>, <item:botania:mana_pearl>, <item:botania:rune_greed>, <item:minecraft:netherite_ingot>);
    #elven trade
        #manaweave cloth
            craftingTable.removeRecipe(<item:botania:manaweave_cloth>);
            <recipetype:botania:elven_trade>.addRecipe("manaweave_cloth_edit", [<item:botania:manaweave_cloth>], <item:botania:mana_string>*4, <item:minecraft:slime_ball>);
        #elementium ingot
            <recipetype:botania:elven_trade>.removeRecipe(<item:botania:elementium_ingot>);
            <recipetype:botania:elven_trade>.addRecipe("elementium_ingot_edit", [<item:botania:elementium_ingot>], <item:botania:manasteel_ingot>, <item:botania:pixie_dust>);
    #removals
        remove(<item:botania:flight_tiara>);
        remove(<item:botania:itemfinder>);
        remove(<item:botania:third_eye>);
        remove(<item:botania:divining_rod>);
        remove(<item:botania:cosmetic_hyper_plus>);
        remove(<item:botania:swap_ring>);
        remove(<item:botania:reach_ring>);
#mekanism
    #other machines
        #solary neutron activator
            #to polonium
                <recipetype:mekanism:activating>.addRecipe("plutonium_to_polonium", GasStackIngredient.from(<gas:mekanism:plutonium>), <gas:mekanism:polonium>);
        #isotropic centrifuge
            #to plutonium
                <recipetype:mekanism:activating>.addRecipe("polonium_to_plutonium", GasStackIngredient.from(<gas:mekanism:polonium>), <gas:mekanism:plutonium>);
        #nucleosynthesizer
            #fission mini
                <recipetype:mekanism:nucleosynthesizing>.addRecipe("fission_reactor_nucleusythesizer", ItemStackIngredient.from(<item:mekanism:dust_fluorite>), GasStackIngredient.from(<gas:mekanism:fissile_fuel> * 2000), <item:mekanism:pellet_polonium>, 100);
            #QIO drives
                #basic
                    craftingTable.removeRecipe(<item:mekanism:qio_drive_base>);
                    <recipetype:mekanism:nucleosynthesizing>.addRecipe("basic_qio_drive_edit", ItemStackIngredient.from(<item:mekanism:ultimate_control_circuit>*4), GasStackIngredient.from(<gas:mekanism:antimatter> * 8), <item:mekanism:qio_drive_base>, 1000);
                #advanced
                    craftingTable.removeRecipe(<item:mekanism:qio_drive_hyper_dense>);
                    <recipetype:mekanism:nucleosynthesizing>.addRecipe("advanced_qio_drive_edit", ItemStackIngredient.from(<item:mekanism:qio_drive_base>*4), GasStackIngredient.from(<gas:mekanism:antimatter> * 16), <item:mekanism:qio_drive_hyper_dense>, 5000);
                #elite
                    craftingTable.removeRecipe(<item:mekanism:qio_drive_time_dilating>);
                    <recipetype:mekanism:nucleosynthesizing>.addRecipe("elite_qio_drive_edit", ItemStackIngredient.from(<item:mekanism:qio_drive_hyper_dense>*4), GasStackIngredient.from(<gas:mekanism:antimatter> * 48), <item:mekanism:qio_drive_time_dilating>, 10000);
                #ultimate
                    craftingTable.removeRecipe(<item:mekanism:qio_drive_supermassive>);
                    <recipetype:mekanism:nucleosynthesizing>.addRecipe("ultimate_qio_drive_edit", ItemStackIngredient.from(<item:mekanism:qio_drive_time_dilating>*4), GasStackIngredient.from(<gas:mekanism:antimatter> * 1280), <item:mekanism:qio_drive_supermassive>, 50000);
            #diamond
                <recipetype:mekanism:nucleosynthesizing>.removeByName("mekanism:nucleosynthesizing/diamond");
                <recipetype:mekanism:nucleosynthesizing>.addRecipe("diamond_edit", ItemStackIngredient.from(<tag:items:minecraft:coals>), GasStackIngredient.from(<gas:mekanism:antimatter> * 1), <item:minecraft:diamond>, 1000);
            #Egolden apple
                <recipetype:mekanism:nucleosynthesizing>.removeByName("mekanism:nucleosynthesizing/enchanted_golden_apple");
                <recipetype:mekanism:nucleosynthesizing>.addRecipe("enchanted_golden_apple_edit", ItemStackIngredient.from(<item:minecraft:golden_apple>), GasStackIngredient.from(<gas:mekanism:antimatter> * 75), <item:minecraft:enchanted_golden_apple>, 30000);
            #removals
                <recipetype:mekanism:nucleosynthesizing>.removeByName("mekanism:nucleosynthesizing/chorus_flower");
                <recipetype:mekanism:nucleosynthesizing>.removeByName("mekanism:nucleosynthesizing/crying_obsidian");
                <recipetype:mekanism:nucleosynthesizing>.removeByName("mekanism:nucleosynthesizing/ender_chest");
                <recipetype:mekanism:nucleosynthesizing>.removeByName("mekanism:nucleosynthesizing/glowstone_block");
                <recipetype:mekanism:nucleosynthesizing>.removeByName("mekanism:nucleosynthesizing/lapis_block");
                <recipetype:mekanism:nucleosynthesizing>.removeByName("mekanism:nucleosynthesizing/quartz_block");
                <recipetype:mekanism:nucleosynthesizing>.removeByName("mekanism:nucleosynthesizing/redstone_block");
                <recipetype:mekanism:nucleosynthesizing>.removeByName("mekanism:nucleosynthesizing/respawn_anchor");
                <recipetype:mekanism:nucleosynthesizing>.removeByName("mekanism:nucleosynthesizing/crossbow");
                <recipetype:mekanism:nucleosynthesizing>.removeByName("mekanism:nucleosynthesizing/emerald");
                <recipetype:mekanism:nucleosynthesizing>.removeByName("mekanism:nucleosynthesizing/end_crystal");
                <recipetype:mekanism:nucleosynthesizing>.removeByName("mekanism:nucleosynthesizing/iron");
        #chemical crystallizer
            #antimatter change
                <recipetype:mekanism:crystallizing>.removeByName("mekanism:processing/lategame/antimatter_pellet/from_gas");
                <recipetype:mekanism:crystallizing>.addRecipe("antimatter_change_crystallizer", GasStackIngredient.from(<gas:mekanism:antimatter> * 100), <item:mekanism:pellet_antimatter>);
        #chemical oxidizer
            #plutonium
                <recipetype:mekanism:oxidizing>.addRecipe("plutonium_oxidizer", ItemStackIngredient.from(<item:mekanism:pellet_plutonium>), <gas:mekanism:plutonium> * 1000);
            #polonium
                <recipetype:mekanism:oxidizing>.addRecipe("polonium_oxidizer", ItemStackIngredient.from(<item:mekanism:pellet_polonium>), <gas:mekanism:polonium> * 1000);
            #antimatter change
                <recipetype:mekanism:oxidizing>.removeByName("mekanism:processing/lategame/antimatter/from_pellet");
                <recipetype:mekanism:oxidizing>.addRecipe("antimatter_change_oxidizer", ItemStackIngredient.from(<item:mekanism:pellet_antimatter>), <gas:mekanism:antimatter> * 100);
        #metallurgic infuser
            #chaotic alloy
                <recipetype:mekanism:metallurgic_infusing>.addRecipe("infuse_chaotic", ItemStackIngredient.from(<item:mekanism:alloy_atomic>), InfusionStackIngredient.from(<infuse_type:kubejs:omega> * 100), <item:kubejs:alloy_chaotic>);
            #added
                <recipetype:mekanism:infusion_conversion>.addRecipe("infusion_conversion/chaotic/from_dust", ItemStackIngredient.from(<item:kubejs:omega_dust>), <infuse_type:kubejs:omega> * 10);
        #enrichment chamber
            #enriched items
                #coal
                    <recipetype:mekanism:enriching>.removeByName("mekanism:enriching/enriched/carbon");
                    <recipetype:mekanism:enriching>.addRecipe("enriched_carbon_edit", ItemStackIngredient.from(<tag:items:minecraft:coals> * 2), <item:mekanism:enriched_carbon>);
                #redstone
                    <recipetype:mekanism:enriching>.removeByName("mekanism:enriching/enriched/redstone");
                    <recipetype:mekanism:enriching>.addRecipe("enriched_redstone_edit", ItemStackIngredient.from(redstone * 2), <item:mekanism:enriched_redstone>);
                #diamond
                    <recipetype:mekanism:enriching>.removeByName("mekanism:enriching/enriched/diamond");
                    <recipetype:mekanism:enriching>.addRecipe("enriched_diamond_edit", ItemStackIngredient.from(<item:minecraft:diamond> * 2), <item:mekanism:enriched_diamond>);
                #obsidian
                    <recipetype:mekanism:enriching>.removeByName("mekanism:enriching/enriched/refined_obsidian");
                    <recipetype:mekanism:enriching>.addRecipe("enriched_odsidian_edit", ItemStackIngredient.from(<item:mekanism:dust_refined_obsidian> * 2), <item:mekanism:enriched_refined_obsidian>);
                #gold
                    <recipetype:mekanism:enriching>.removeByName("mekanism:enriching/enriched/gold");
                    <recipetype:mekanism:enriching>.addRecipe("enriched_gold_edit", ItemStackIngredient.from(<tag:items:forge:dusts/gold> * 2), <item:mekanism:enriched_gold>);
                #tin
                    <recipetype:mekanism:enriching>.removeByName("mekanism:enriching/enriched/tin");
                    <recipetype:mekanism:enriching>.addRecipe("enriched_tin_edit", ItemStackIngredient.from(<tag:items:forge:dusts/tin> * 2), <item:mekanism:enriched_tin>);
    #items
        #personal chest
            craftingTable.removeRecipe(<item:mekanism:personal_chest>);
            craftingTable.addShaped("personal_chest_edit", <item:mekanism:personal_chest>, [
                [steelPlate, <tag:items:forge:glass>, steelPlate],
                [<tag:items:forge:chests/wooden>, <item:mekanism:elite_control_circuit>, <tag:items:forge:chests/wooden>],
                [steelPlate, steelPlate, steelPlate]]);
        #thermal evaporation
            #block
                craftingTable.removeRecipe(<item:mekanism:thermal_evaporation_block>);
                craftingTable.addShaped("thermal_evaporation_block_edit", <item:mekanism:thermal_evaporation_block> * 4, [
                    [air, steelPlate, air],
                    [steelPlate, copperPlate, steelPlate],
                    [air, steelPlate, air]]);
            #valve
                craftingTable.removeRecipe(<item:mekanism:thermal_evaporation_valve>);
                craftingTable.addShaped("thermal_evaporation_valve_edit", <item:mekanism:thermal_evaporation_valve>, [
                    [air, <item:mekanism:thermal_evaporation_block>, air],
                    [<item:mekanism:thermal_evaporation_block>, <item:mekanism:ultimate_control_circuit>, <item:mekanism:thermal_evaporation_block>],
                    [air, <item:mekanism:thermal_evaporation_block>, air]]);
            #controller
                craftingTable.removeRecipe(<item:mekanism:thermal_evaporation_controller>);
                craftingTable.addShaped("thermal_evaporation_controller_edit", <item:mekanism:thermal_evaporation_controller>, [
                    [<item:mekanism:ultimate_control_circuit>, <tag:items:forge:glass_panes>, <item:mekanism:ultimate_control_circuit>],
                    [<item:mekanism:thermal_evaporation_block>, <item:kubejs:omega_ingot>, <item:mekanism:thermal_evaporation_block>],
                    [<item:mekanism:thermal_evaporation_block>, <item:mekanism:thermal_evaporation_block>, <item:mekanism:thermal_evaporation_block>]]);
        #nucleosynthesizer
            craftingTable.removeRecipe(<item:mekanism:antiprotonic_nucleosynthesizer>);
            craftingTable.addShaped("antiprotonic_nucleosynthesizer_edit", <item:mekanism:antiprotonic_nucleosynthesizer>, [
                [<item:mekanism:alloy_atomic>, <item:mekanism:ultimate_control_circuit>, <item:mekanism:alloy_atomic>],
                [<item:mekanism:pellet_antimatter>, <item:kubejs:reactor_core>, <item:mekanism:pellet_antimatter>],
                [<item:mekanism:alloy_atomic>, <item:mekanism:ultimate_control_circuit>, <item:mekanism:alloy_atomic>]]);
        #basic induction provider
            craftingTable.removeRecipe(<item:mekanism:basic_induction_provider>);
            craftingTable.addShaped("basic_induction_provider", <item:mekanism:basic_induction_provider>, [
                [<item:mekanism:dust_lithium>, <item:mekanism:basic_control_circuit>, <item:mekanism:dust_lithium>],
                [<item:mekanism:basic_control_circuit>, <item:kubejs:omega_dust>, <item:mekanism:basic_control_circuit>],
                [<item:mekanism:dust_lithium>, <item:mekanism:basic_control_circuit>, <item:mekanism:dust_lithium>]]);
        #generators
            #heat gen
                craftingTable.removeRecipe(<item:mekanismgenerators:heat_generator>);
                craftingTable.addShaped("heat_generator_edit", <item:mekanismgenerators:heat_generator>, [
                    [ironPlate, ironPlate, ironPlate],
                    [copperPlate, <item:mekanism:ingot_osmium>, copperPlate],
                    [<tag:items:forge:storage_blocks/copper>, <item:minecraft:furnace>, <tag:items:forge:storage_blocks/copper>]]);
            #solar gen
                craftingTable.removeRecipe(<item:mekanismgenerators:solar_generator>);
                craftingTable.addShaped("solar_generator_edit", <item:mekanismgenerators:solar_generator>, [
                    [<item:mekanismgenerators:solar_panel>, <item:mekanismgenerators:solar_panel>, <item:mekanismgenerators:solar_panel>],
                    [<item:mekanism:energy_tablet>, <item:mekanism:alloy_infused>, <item:mekanism:energy_tablet>],
                    [ironPlate, ironPlate, ironPlate]]);
            #solar panel
                craftingTable.removeRecipe(<item:mekanismgenerators:solar_panel>);
                craftingTable.addShaped("solar_panel_edit", <item:mekanismgenerators:solar_panel>, [
                    [<tag:items:forge:glass>, <tag:items:forge:glass>, <tag:items:forge:glass>],
                    [redstone, <item:mekanism:alloy_infused>, redstone],
                    [<item:mekanism:ingot_osmium>, <item:mekanism:ingot_osmium>, <item:mekanism:ingot_osmium>]]);
            #adv solar gen
                craftingTable.removeRecipe(<item:mekanismgenerators:advanced_solar_generator>);
                craftingTable.addShaped("advanced_solar_generator_edit", <item:mekanismgenerators:advanced_solar_generator>, [
                    [<item:mekanismgenerators:solar_generator>, <item:mekanism:alloy_reinforced>, <item:mekanismgenerators:solar_generator>],
                    [<item:mekanismgenerators:solar_generator>, <item:mekanism:alloy_reinforced>, <item:mekanismgenerators:solar_generator>],
                    [ironPlate, ironPlate, ironPlate]]);
            #bio gen
                craftingTable.removeRecipe(<item:mekanismgenerators:bio_generator>);
                craftingTable.addShaped("bio_generator_edit", <item:mekanismgenerators:bio_generator>, [
                    [redstone, <item:mekanism:alloy_infused>, redstone],
                    [<item:mekanism:bio_fuel>, <item:mekanism:basic_control_circuit>, <item:mekanism:bio_fuel>],
                    [ironPlate, <item:mekanism:alloy_infused>, ironPlate]]);
        #digital miner
            craftingTable.removeRecipe(<item:mekanism:digital_miner>);
            craftingTable.addShaped("digital_miner_edit", <item:mekanism:digital_miner>, [
                [<item:mekanism:induction_casing>, <item:mekanism:ultimate_control_circuit>, <item:mekanism:induction_casing>],
                [<item:mekanismgenerators:turbine_casing>, <item:mekanism:steel_casing>, <item:mekanismgenerators:turbine_casing>],
                [<item:mekanism:teleportation_core>, <item:mekanism:induction_port>, <item:mekanism:teleportation_core>]]);
        #steel casing
            craftingTable.removeRecipe(<item:mekanism:steel_casing>);
            craftingTable.addShaped("steel_casing_edit", <item:mekanism:steel_casing>, [
                [steelPlate, ironPlate, steelPlate],
                [ironPlate, <item:mekanism:ingot_osmium>, ironPlate],
                [steelPlate, ironPlate, steelPlate]]);
        #mekanismgenerators casing etc
            #fission fuel assembly
                craftingTable.removeRecipe(<item:mekanismgenerators:fission_fuel_assembly>);
                craftingTable.addShaped("fission_fuel_assembly_edit", <item:mekanismgenerators:fission_fuel_assembly>, [
                    [leadPlate, <item:mekanism:ultimate_chemical_tank>, leadPlate],
                    [leadPlate, <item:mekanismgenerators:fission_reactor_casing>, leadPlate],
                    [leadPlate, <item:mekanism:ultimate_chemical_tank>, leadPlate]]);
            #electromagnetic coil
                craftingTable.removeRecipe(<item:mekanismgenerators:electromagnetic_coil>);
                craftingTable.addShaped("electromagnetic_coil_edit", <item:mekanismgenerators:electromagnetic_coil>, [
                    [<item:mekanism:energy_tablet>, <item:immersiveengineering:coil_lv>, <item:mekanism:energy_tablet>],
                    [<item:immersiveengineering:coil_lv>, <tag:items:forge:storage_blocks/gold>, <item:immersiveengineering:coil_lv>],
                    [<item:mekanism:energy_tablet>, <item:immersiveengineering:coil_lv>, <item:mekanism:energy_tablet>]]);
            #turbine rotor
                craftingTable.removeRecipe(<item:mekanismgenerators:turbine_rotor>);
                craftingTable.addShaped("turbine_rotor_edit", <item:mekanismgenerators:turbine_rotor>, [
                    [<tag:items:forge:storage_blocks/steel>],
                    [<tag:items:forge:storage_blocks/steel>],
                    [<tag:items:forge:storage_blocks/steel>]]);
            #turbine blade
                craftingTable.removeRecipe(<item:mekanismgenerators:turbine_blade>);
                craftingTable.addShaped("turbine_blade_mekanism_edit", <item:mekanismgenerators:turbine_blade>, [
                    [air, steelPlate, air],
                    [steelPlate, <item:mekanism:alloy_infused>, steelPlate],
                    [air, steelPlate, air]]);
            #rotational complex
                craftingTable.removeRecipe(<item:mekanismgenerators:rotational_complex>);
                craftingTable.addShaped("rotational_complex_edit", <item:mekanismgenerators:rotational_complex>, [
                    [steelPlate, <item:mekanism:alloy_infused>, steelPlate],
                    [<item:mekanism:ultimate_control_circuit>, <item:mekanism:alloy_infused>, <item:mekanism:ultimate_control_circuit>],
                    [steelPlate, <item:mekanism:alloy_infused>, steelPlate]]);
            #fission casing
                craftingTable.removeRecipe(<item:mekanismgenerators:fission_reactor_casing>);
                craftingTable.addShaped("fission_reactor_casing_edit", <item:mekanismgenerators:fission_reactor_casing> * 8, [
                    [leadPlate, leadPlate, leadPlate],
                    [leadPlate, <item:kubejs:reactor_core>, leadPlate],
                    [leadPlate, leadPlate, leadPlate]]);
            #turbine casing
                craftingTable.removeRecipe(<item:mekanismgenerators:turbine_casing>);
                craftingTable.addShaped("turbine_casing_edit", <item:mekanismgenerators:turbine_casing>, [
                    [air, steelPlate, air],
                    [steelPlate, <item:kubejs:alloy_chaotic>, steelPlate],
                    [air, steelPlate, air]]);
            #fusion frame
                craftingTable.removeRecipe(<item:mekanismgenerators:fusion_reactor_frame>);
                craftingTable.addShaped("fusion_reactor_frame_edit", <item:mekanismgenerators:fusion_reactor_frame> * 4, [
                    [<item:kubejs:alloy_chaotic>, <item:mekanism:pellet_polonium>, <item:kubejs:alloy_chaotic>],
                    [<item:mekanism:pellet_polonium>, <item:kubejs:reactor_core>, <item:mekanism:pellet_polonium>],
                    [<item:kubejs:alloy_chaotic>, <item:mekanism:pellet_polonium>, <item:kubejs:alloy_chaotic>]]);
            #pressure disperser
                craftingTable.removeRecipe(<item:mekanism:pressure_disperser>);
                craftingTable.addShaped("pressure_disperser_edit", <item:mekanism:pressure_disperser>, [
                    [steelPlate, <item:minecraft:iron_bars>, steelPlate],
                    [<item:minecraft:iron_bars>, <item:mekanism:alloy_atomic>, <item:minecraft:iron_bars>],
                    [steelPlate, <item:minecraft:iron_bars>, steelPlate]]);
            #saturating condenser
                craftingTable.removeRecipe(<item:mekanismgenerators:saturating_condenser>);
                craftingTable.addShaped("saturating_condenser_edit", <item:mekanismgenerators:saturating_condenser>, [
                    [steelPlate, tinPlate, steelPlate],
                    [tinPlate, <item:mekanismgenerators:turbine_casing>, tinPlate],
                    [steelPlate, tinPlate, steelPlate]]);
            #control rod assembly
                craftingTable.removeRecipe(<item:mekanismgenerators:control_rod_assembly>);
                craftingTable.addShaped("control_rod_assembly_edit", <item:mekanismgenerators:control_rod_assembly>, [
                    [leadPlate, <item:mekanism:ultimate_control_circuit>, leadPlate],
                    [steelPlate, <item:mekanismgenerators:fission_reactor_casing>, steelPlate],
                    [steelPlate, leadPlate, steelPlate]]);
        #energy tablet
            craftingTable.removeRecipe(<item:mekanism:energy_tablet>);
            craftingTable.addShaped("energy_tablet_edit", <item:mekanism:energy_tablet>, [
                [steelPlate, steelPlate, steelPlate],
                [<item:mekanism:alloy_atomic>, <item:minecraft:emerald>, <item:mekanism:alloy_atomic>],
                [redstone, <item:minecraft:gold_ingot>, redstone]]);
        #atomic dissasembler
            craftingTable.removeRecipe(<item:mekanism:atomic_disassembler>);
            craftingTable.addShaped("atomic_disassembler_editr", <item:mekanism:atomic_disassembler>, [
                [<item:mekanism:energy_tablet>, <item:mekanism:ultimate_control_circuit>, <item:mekanism:energy_tablet>],
                [<item:mekanism:alloy_reinforced>, <item:mekanism:alloy_atomic>, <item:mekanism:alloy_reinforced>],
                [<item:minecraft:air>, <item:mekanism:ingot_refined_obsidian>, <item:minecraft:air>]]);
        #containers
            #fluid tanks
                #basic
                    craftingTable.removeRecipe(<item:mekanism:basic_fluid_tank>);
                    craftingTable.addShaped("basic_fluid_tank_edit", <item:mekanism:basic_fluid_tank>, [
                        [redstone, <item:immersiveengineering:plate_iron>, redstone],
                        [<item:immersiveengineering:plate_iron>, <item:minecraft:air>, <item:immersiveengineering:plate_iron>],
                        [redstone, <item:immersiveengineering:plate_iron>, redstone]]);
                #advanced
                    craftingTable.removeRecipe(<item:mekanism:advanced_fluid_tank>);
                    craftingTable.addShaped("advanced_fluid_tank_edit", <item:mekanism:advanced_fluid_tank>, [
                        [<item:mekanism:advanced_control_circuit>, <item:immersiveengineering:plate_iron>, <item:mekanism:advanced_control_circuit>],
                        [<item:immersiveengineering:plate_iron>, <item:mekanism:basic_fluid_tank>, <item:immersiveengineering:plate_iron>],
                        [<item:mekanism:advanced_control_circuit>, <item:immersiveengineering:plate_iron>, <item:mekanism:advanced_control_circuit>]]);
                #elite
                    craftingTable.removeRecipe(<item:mekanism:elite_fluid_tank>);
                    craftingTable.addShaped("elite_fluid_tank_edit", <item:mekanism:elite_fluid_tank>, [
                        [<item:mekanism:elite_control_circuit>, <item:immersiveengineering:plate_iron>, <item:mekanism:elite_control_circuit>],
                        [<item:immersiveengineering:plate_iron>, <item:mekanism:advanced_fluid_tank>, <item:immersiveengineering:plate_iron>],
                        [<item:mekanism:elite_control_circuit>, <item:immersiveengineering:plate_iron>, <item:mekanism:elite_control_circuit>]]);
                #ultimate
                    craftingTable.removeRecipe(<item:mekanism:ultimate_fluid_tank>);
                    craftingTable.addShaped("ultimate_fluid_tank_edit", <item:mekanism:ultimate_fluid_tank>, [
                        [<item:mekanism:ultimate_control_circuit>, <item:immersiveengineering:plate_iron>, <item:mekanism:ultimate_control_circuit>],
                        [<item:immersiveengineering:plate_iron>, <item:mekanism:elite_fluid_tank>, <item:immersiveengineering:plate_iron>],
                        [<item:mekanism:ultimate_control_circuit>, <item:immersiveengineering:plate_iron>, <item:mekanism:ultimate_control_circuit>]]);
            #chemical tanks
                #basic
                    craftingTable.removeRecipe(<item:mekanism:basic_chemical_tank>);
                    craftingTable.addShaped("basic_chemical_tank_edit", <item:mekanism:basic_chemical_tank>, [
                        [redstone, <item:mekanism:ingot_osmium>, redstone],
                        [<item:mekanism:ingot_osmium>, <item:minecraft:air>, <item:mekanism:ingot_osmium>],
                        [redstone, <item:mekanism:ingot_osmium>, redstone]]);
                #advanced
                    craftingTable.removeRecipe(<item:mekanism:advanced_chemical_tank>);
                    craftingTable.addShaped("advanced_chemical_tank_edit", <item:mekanism:advanced_chemical_tank>, [
                        [<item:mekanism:advanced_control_circuit>, <item:mekanism:ingot_osmium>, <item:mekanism:advanced_control_circuit>],
                        [<item:mekanism:ingot_osmium>, <item:mekanism:basic_chemical_tank>, <item:mekanism:ingot_osmium>],
                        [<item:mekanism:advanced_control_circuit>, <item:mekanism:ingot_osmium>, <item:mekanism:advanced_control_circuit>]]);
                #elite
                    craftingTable.removeRecipe(<item:mekanism:elite_chemical_tank>);
                    craftingTable.addShaped("elite_chemical_tank_edit", <item:mekanism:elite_chemical_tank>, [
                        [<item:mekanism:elite_control_circuit>, <item:mekanism:ingot_osmium>, <item:mekanism:elite_control_circuit>],
                        [<item:mekanism:ingot_osmium>, <item:mekanism:advanced_chemical_tank>, <item:mekanism:ingot_osmium>],
                        [<item:mekanism:elite_control_circuit>, <item:mekanism:ingot_osmium>, <item:mekanism:elite_control_circuit>]]);
                #ultimate
                    craftingTable.removeRecipe(<item:mekanism:ultimate_chemical_tank>);
                    craftingTable.addShaped("ultimate_chemical_tank_edit", <item:mekanism:ultimate_chemical_tank>, [
                        [<item:mekanism:ultimate_control_circuit>, <item:mekanism:ingot_osmium>, <item:mekanism:ultimate_control_circuit>],
                        [<item:mekanism:ingot_osmium>, <item:mekanism:elite_chemical_tank>, <item:mekanism:ingot_osmium>],
                        [<item:mekanism:ultimate_control_circuit>, <item:mekanism:ingot_osmium>, <item:mekanism:ultimate_control_circuit>]]);
        #cables
            #energy
                craftingTable.removeRecipe(<item:mekanism:basic_universal_cable>);
                craftingTable.addShaped("energy_cable_edit", <item:mekanism:basic_universal_cable>, [
                    [<item:minecraft:air>, <item:minecraft:air>, <item:minecraft:air>],
                    [<item:mekanism:block_steel>, redstone, <item:mekanism:block_steel>],
                    [<item:minecraft:air>, <item:minecraft:air>, <item:minecraft:air>]]);
            #fluid
                craftingTable.removeRecipe(<item:mekanism:basic_mechanical_pipe>);
                craftingTable.addShaped("fluid_pipe_edit", <item:mekanism:basic_mechanical_pipe>, [
                    [<item:minecraft:air>, <item:minecraft:air>, <item:minecraft:air>],
                    [<item:mekanism:block_steel>, <item:minecraft:bucket>, <item:mekanism:block_steel>],
                    [<item:minecraft:air>, <item:minecraft:air>, <item:minecraft:air>]]);
            #gas
                craftingTable.removeRecipe(<item:mekanism:basic_pressurized_tube>);
                craftingTable.addShaped("gas_tube_edit", <item:mekanism:basic_pressurized_tube>, [
                    [<item:minecraft:air>, <item:minecraft:air>, <item:minecraft:air>],
                    [<item:mekanism:block_steel>, <tag:items:forge:glass>, <item:mekanism:block_steel>],
                    [<item:minecraft:air>, <item:minecraft:air>, <item:minecraft:air>]]);
            #item
                craftingTable.removeRecipe(<item:mekanism:basic_logistical_transporter>);
                craftingTable.addShaped("item_cable_edit", <item:mekanism:basic_logistical_transporter>, [
                    [<item:minecraft:air>, <item:minecraft:air>, <item:minecraft:air>],
                    [<item:mekanism:block_steel>, <item:mekanism:basic_control_circuit>, <item:mekanism:block_steel>],
                    [<item:minecraft:air>, <item:minecraft:air>, <item:minecraft:air>]]);
            #thermo
                craftingTable.removeRecipe(<item:mekanism:basic_thermodynamic_conductor>);
                craftingTable.addShaped("thermo_cable_edit", <item:mekanism:basic_thermodynamic_conductor>, [
                    [<item:minecraft:air>, <item:minecraft:air>, <item:minecraft:air>],
                    [<item:mekanism:block_steel>, <tag:items:forge:ingots/copper>, <item:mekanism:block_steel>],
                    [<item:minecraft:air>, <item:minecraft:air>, <item:minecraft:air>]]);
        #control circuits
            #advanced
                craftingTable.removeRecipe(<item:mekanism:advanced_control_circuit>);
                craftingTable.addShaped("advanced_control_circuit_edit", <item:mekanism:advanced_control_circuit>, [
                    [<item:minecraft:air>, <item:mekanism:alloy_infused>, <item:minecraft:air>], 
                    [<item:mekanism:alloy_infused>, <item:mekanism:basic_control_circuit>, <item:mekanism:alloy_infused>], 
                    [<item:minecraft:air>, <item:mekanism:alloy_infused>, <item:minecraft:air>]]);
            #elite
                craftingTable.removeRecipe(<item:mekanism:elite_control_circuit>);
                craftingTable.addShaped("elite_control_circuit_edit", <item:mekanism:elite_control_circuit>, [
                    [<item:minecraft:air>, <item:mekanism:alloy_reinforced>, <item:minecraft:air>], 
                    [<item:mekanism:alloy_reinforced>, <item:mekanism:advanced_control_circuit>, <item:mekanism:alloy_reinforced>], 
                    [<item:minecraft:air>, <item:mekanism:alloy_reinforced>, <item:minecraft:air>]]);
            #ultimate
                craftingTable.removeRecipe(<item:mekanism:ultimate_control_circuit>);
                craftingTable.addShaped("ultimate_control_circuit_edit", <item:mekanism:ultimate_control_circuit>, [
                    [air, <item:mekanism:alloy_atomic>, air], 
                    [<item:mekanism:alloy_atomic>, <item:mekanism:elite_control_circuit>, <item:mekanism:alloy_atomic>], 
                    [air, <item:mekanism:alloy_atomic>, air]]);
            #chaotic_control_circuit
                craftingTable.removeRecipe(<item:kubejs:chaotic_control_circuit>);
                craftingTable.addShaped("chaotic_control_circuit", <item:kubejs:chaotic_control_circuit>, [
                    [<item:kubejs:alloy_chaotic>, <item:mekanism:ultimate_control_circuit>, <item:kubejs:alloy_chaotic>],
                    [<item:draconicevolution:awakened_draconium_block>, <item:kubejs:alloy_chaotic>, <item:draconicevolution:awakened_draconium_block>],
                    [<item:kubejs:alloy_chaotic>, <item:mekanism:ultimate_control_circuit>, <item:kubejs:alloy_chaotic>]]);
    #more processing changes
        #ruby
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:gem_ruby>);
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:dust_ruby>);
            <recipetype:mekanism:enriching>.removeByName("moremekanismprocessing:processing/ruby/gem/from_dust");
            <recipetype:mekanism:enriching>.removeByName("moremekanismprocessing:processing/ruby/gem/from_ore");
            <recipetype:mekanism:enriching>.removeByName("moremekanismprocessing:processing/ruby/dust/from_dirty_dust");
            <recipetype:mekanism:crushing>.removeByName("moremekanismprocessing:processing/ruby/dust/from_gem");
            <recipetype:mekanism:enriching>.addRecipe("ruby_dust_more_mekanism", ItemStackIngredient.from(<item:moremekanismprocessing:dirty_dust_ruby>), <item:thermal:ruby_dust>);
            <recipetype:mekanism:enriching>.addRecipe("ruby_dust_from_gem_more_mekanism", ItemStackIngredient.from(<item:thermal:ruby>), <item:thermal:ruby_dust>);
        #niter
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:gem_niter>);
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:dust_niter>);
            <recipetype:mekanism:enriching>.removeByName("moremekanismprocessing:processing/niter/gem/from_dust");
            <recipetype:mekanism:enriching>.removeByName("moremekanismprocessing:processing/niter/gem/from_ore");
            <recipetype:mekanism:enriching>.removeByName("moremekanismprocessing:processing/niter/dust/from_dirty_dust");
            <recipetype:mekanism:crushing>.removeByName("moremekanismprocessing:processing/niter/dust/from_gem");
            <recipetype:mekanism:enriching>.addRecipe("niter_dust_more_mekanism", ItemStackIngredient.from(<item:moremekanismprocessing:dirty_dust_niter>), <item:thermal:niter_dust>);
            <recipetype:mekanism:enriching>.addRecipe("niter_dust_from_gem_more_mekanism", ItemStackIngredient.from(<item:thermal:niter>), <item:thermal:niter_dust>);
        #apatite
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:gem_apatite>);
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:dust_apatite>);
            <recipetype:mekanism:enriching>.removeByName("moremekanismprocessing:processing/apatite/gem/from_dust");
            <recipetype:mekanism:enriching>.removeByName("moremekanismprocessing:processing/apatite/gem/from_ore");
            <recipetype:mekanism:enriching>.removeByName("moremekanismprocessing:processing/apatite/dust/from_dirty_dust");
            <recipetype:mekanism:crushing>.removeByName("moremekanismprocessing:processing/apatite/dust/from_gem");
            <recipetype:mekanism:enriching>.addRecipe("apatite_dust_more_mekanism", ItemStackIngredient.from(<item:moremekanismprocessing:dirty_dust_apatite>), <item:thermal:apatite_dust>);
            <recipetype:mekanism:enriching>.addRecipe("apatite_dust_from_gem_more_mekanism", ItemStackIngredient.from(<item:thermal:apatite>), <item:thermal:apatite_dust>);
        #sapphire
            removeMekanismProcessingAll("sapphire", "gem");
        #cinnabar
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:gem_cinnabar>);
            <recipetype:mekanism:enriching>.removeByName("moremekanismprocessing:processing/cinnabar/gem/from_dust");
            <recipetype:mekanism:enriching>.removeByName("moremekanismprocessing:processing/cinnabar/gem/from_ore");
        #amethyst
            removeMekanismProcessingAll("amethyst", "gem");
        #cobalt
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:cobalt_ingot>);
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:cobalt_nugget>);
            craftingTable.removeRecipe(<item:moremekanismprocessing:cobalt_ingot>);
            craftingTable.removeRecipe(<item:moremekanismprocessing:cobalt_nugget>);
            blastFurnace.removeRecipe(<item:moremekanismprocessing:cobalt_ingot>);
            furnace.removeRecipe(<item:moremekanismprocessing:cobalt_ingot>);
            furnace.addRecipe("cobalt_ingot_furnace", <item:tconstruct:cobalt_ingot>, <item:moremekanismprocessing:dust_cobalt>, 0, 10);
            blastFurnace.addRecipe("cobalt_ingot_blast", <item:tconstruct:cobalt_ingot>, <item:moremekanismprocessing:dust_cobalt>, 0, 5);
            <recipetype:immersiveengineering:arc_furnace>.addRecipe("cobalt_ingot_arc", <item:moremekanismprocessing:dust_cobalt>, [air], 100, 51200, [<item:tconstruct:cobalt_ingot>]);
            <recipetype:immersiveengineering:arc_furnace>.removeRecipe(<item:moremekanismprocessing:cobalt_ingot>);
        #zinc
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:zinc_ingot>);
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:zinc_nugget>);
            craftingTable.removeRecipe(<item:moremekanismprocessing:zinc_ingot>);
            craftingTable.removeRecipe(<item:moremekanismprocessing:zinc_nugget>);
            blastFurnace.removeRecipe(<item:moremekanismprocessing:zinc_ingot>);
            furnace.removeRecipe(<item:moremekanismprocessing:zinc_ingot>);
            furnace.addRecipe("zinc_ingot_furnace", <item:create:zinc_ingot>, <item:moremekanismprocessing:dust_zinc>, 0, 10);
            blastFurnace.addRecipe("zinc_ingot_blast", <item:create:zinc_ingot>, <item:moremekanismprocessing:dust_zinc>, 0, 5);
        #silver
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:dust_silver>);
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:silver_ingot>);
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:silver_nugget>);
            craftingTable.removeRecipe(<item:moremekanismprocessing:silver_ingot>);
            craftingTable.removeRecipe(<item:moremekanismprocessing:silver_nugget>);
            blastFurnace.removeRecipe(<item:moremekanismprocessing:silver_ingot>);
            furnace.removeRecipe(<item:moremekanismprocessing:silver_ingot>);
            <recipetype:mekanism:enriching>.removeByName("moremekanismprocessing:processing/silver/dust/from_dirty_dust");
            <recipetype:mekanism:enriching>.addRecipe("silver_dust_more_mekanism", ItemStackIngredient.from(<item:moremekanismprocessing:dirty_dust_silver>), <item:immersiveengineering:dust_silver>);
        #nickel
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:dust_nickel>);
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:nickel_ingot>);
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:nickel_nugget>);
            craftingTable.removeRecipe(<item:moremekanismprocessing:nickel_ingot>);
            craftingTable.removeRecipe(<item:moremekanismprocessing:nickel_nugget>);
            blastFurnace.removeRecipe(<item:moremekanismprocessing:nickel_ingot>);
            furnace.removeRecipe(<item:moremekanismprocessing:nickel_ingot>);
            <recipetype:mekanism:enriching>.removeByName("moremekanismprocessing:processing/nickel/dust/from_dirty_dust");
            <recipetype:mekanism:enriching>.addRecipe("nickel_dust_more_mekanism", ItemStackIngredient.from(<item:moremekanismprocessing:dirty_dust_nickel>), <item:immersiveengineering:dust_nickel>);
        #lithium
            removeMekanismProcessingAll("lithium", "ingot");
        #aluminum
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:dust_aluminum>);
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:aluminum_ingot>);
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:aluminum_nugget>);
            craftingTable.removeRecipe(<item:moremekanismprocessing:aluminum_ingot>);
            craftingTable.removeRecipe(<item:moremekanismprocessing:aluminum_nugget>);
            blastFurnace.removeRecipe(<item:moremekanismprocessing:aluminum_ingot>);
            furnace.removeRecipe(<item:moremekanismprocessing:aluminum_ingot>);
            <recipetype:mekanism:enriching>.removeByName("moremekanismprocessing:processing/aluminum/dust/from_dirty_dust");
            <recipetype:mekanism:enriching>.addRecipe("aluminum_dust_more_mekanism", ItemStackIngredient.from(<item:moremekanismprocessing:dirty_dust_aluminum>), <item:immersiveengineering:dust_aluminum>);
        #tungsten
            removeMekanismProcessing("tungsten");
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:dust_tungsten>);
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:tungsten_nugget>);
            blastFurnace.removeRecipe(<item:moremekanismprocessing:tungsten_ingot>);
            furnace.removeRecipe(<item:moremekanismprocessing:tungsten_ingot>);
        #titanium
            removeMekanismProcessingAll("titanium", "ingot");
        #silicon
            removeMekanismProcessingAll("silicon", "ingot");
        #peridot
            removeMekanismProcessingAll("peridot", "gem");
        #iridium
            removeMekanismProcessingAll("iridium", "ingot");
        #green sapphire
            removeMekanismProcessingAll("green_sapphire", "gem");
        #electrotine
            removeMekanismProcessing("electrotine");
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:dust_electrotine>);
        #dilithium
            removeMekanismProcessingAll("dilithium", "gem");
        #desh
            removeMekanismProcessingAll("desh", "ingot");
        #bort
            removeMekanismProcessingAll("bort", "gem");
        #azure silver
            <recipetype:mekanism:washing>.removeByName("moremekanismprocessing:processing/azure_silver/slurry/clean");
            <recipetype:mekanism:crystallizing>.removeByName("moremekanismprocessing:processing/azure_silver/crystal/from_slurry");
            <recipetype:mekanism:injecting>.removeByName("moremekanismprocessing:processing/azure_silver/shard/from_crystal");
            <recipetype:mekanism:purifying>.removeByName("moremekanismprocessing:processing/azure_silver/clump/from_shard");
            <recipetype:mekanism:crushing>.removeByName("moremekanismprocessing:processing/azure_silver/dirty_dust/from_clump");
            <recipetype:mekanism:enriching>.removeByName("moremekanismprocessing:processing/azure_silver/dust/from_dirty_dust");
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:shard_azure_silver>);
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:clump_azure_silver>);
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:dirty_dust_azure_silver>);
            mods.jei.JEI.hideIngredient(<slurry:moremekanismprocessing:clean_azure_silver>);
            mods.jei.JEI.hideIngredient(<slurry:moremekanismprocessing:dirty_azure_silver>);
            remove(<item:moremekanismprocessing:azure_silver_ingot>);
            remove(<item:moremekanismprocessing:azure_silver_nugget>);
            blastFurnace.removeRecipe(<item:moremekanismprocessing:azure_silver_ingot>);
            furnace.removeRecipe(<item:moremekanismprocessing:azure_silver_ingot>);
            <recipetype:mekanism:crushing>.removeByName("moremekanismprocessing:processing/azure_silver/dust/from_ingot");
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:dust_azure_silver>);
            //this is because I want to use the azure silver crystal for crafts
        #crimsoniron
            removeMekanismProcessingAll("crimson_iron", "ingot");
        #platinum
            removeMekanismProcessing("platinum");
        #bismuth
            removeMekanismProcessingAll("bismuth", "ingot");
        #draconium
            blastFurnace.removeRecipe(<item:moremekanismprocessing:draconium_ingot>);
            furnace.removeRecipe(<item:moremekanismprocessing:draconium_ingot>);
            craftingTable.removeRecipe(<item:moremekanismprocessing:draconium_ingot>);
            mods.jei.JEI.hideItem(<item:moremekanismprocessing:draconium_ingot>);
    #removals
        remove(<item:mekanism:mekasuit_helmet>);
        remove(<item:mekanism:mekasuit_bodyarmor>);
        remove(<item:mekanism:mekasuit_pants>);
        remove(<item:mekanism:mekasuit_boots>);
        remove(<item:mekanism:meka_tool>);
        remove(<item:mekanism:module_base>);
        remove(<item:mekanism:module_energy_unit>);
        remove(<item:mekanism:module_laser_dissipation_unit>);
        remove(<item:mekanism:module_radiation_shielding_unit>);
        remove(<item:mekanism:module_excavation_escalation_unit>);
        remove(<item:mekanism:module_attack_amplification_unit>);
        remove(<item:mekanism:module_farming_unit>);
        remove(<item:mekanism:module_shearing_unit>);
        remove(<item:mekanism:module_silk_touch_unit>);
        remove(<item:mekanism:module_vein_mining_unit>);
        remove(<item:mekanism:module_teleportation_unit>);
        remove(<item:mekanism:module_electrolytic_breathing_unit>);
        remove(<item:mekanism:module_inhalation_purification_unit>);
        remove(<item:mekanism:module_vision_enhancement_unit>);
        remove(<item:mekanism:module_solar_recharging_unit>);
        remove(<item:mekanism:module_nutritional_injection_unit>);
        remove(<item:mekanism:module_dosimeter_unit>);
        remove(<item:mekanism:module_geiger_unit>);
        remove(<item:mekanism:module_jetpack_unit>);
        remove(<item:mekanism:module_charge_distribution_unit>);
        remove(<item:mekanism:module_gravitational_modulating_unit>);
        remove(<item:mekanism:module_elytra_unit>);
        remove(<item:mekanism:module_locomotive_boosting_unit>);
        remove(<item:mekanism:module_hydraulic_propulsion_unit>);
        remove(<item:mekanism:module_magnetic_attraction_unit>);
        remove(<item:mekanism:module_frost_walker_unit>);
        remove(<item:mekanismgenerators:module_geothermal_generator_unit>);
        remove(<item:mekanismtools:wood_paxel>);
        remove(<item:mekanismtools:stone_paxel>);
        remove(<item:mekanismtools:iron_paxel>);
        remove(<item:mekanismtools:gold_paxel>);
        remove(<item:mekanismtools:diamond_paxel>);
        remove(<item:mekanismtools:netherite_paxel>);
        remove(<item:mekanismtools:bronze_paxel>);
        remove(<item:mekanismtools:lapis_lazuli_paxel>);
        remove(<item:mekanismtools:osmium_paxel>);
        remove(<item:mekanismtools:refined_glowstone_paxel>);
        remove(<item:mekanismtools:refined_obsidian_paxel>);
        remove(<item:mekanismtools:steel_paxel>);
        remove(<item:mekanism:portable_teleporter>);
        remove(<item:mekanism:jetpack>);
        remove(<item:mekanism:jetpack_armored>);
        remove(<item:mekanism:basic_bin>);
        remove(<item:mekanism:advanced_bin>);
        remove(<item:mekanism:elite_bin>);
        remove(<item:mekanism:ultimate_bin>);
        remove(<item:mekanism:creative_bin>);
#cyclic
    #removals
        remove(<item:cyclic:elevation_wand>);
        remove(<item:cyclic:charm_speed>);
        remove(<item:cyclic:chorus_flight>);
        remove(<item:cyclic:charm_void>);
        remove(<item:cyclic:placer_fluid>);
        remove(<item:cyclic:crystal_shovel>);
        remove(<item:cyclic:crystal_hoe>);
        remove(<item:cyclic:crystal_axe>);
        remove(<item:cyclic:crystal_pickaxe>);
        remove(<item:cyclic:crystal_sword>);
        remove(<item:cyclic:crystal_boots>);
        remove(<item:cyclic:crystal_leggings>);
        remove(<item:cyclic:crystal_chestplate>);
        remove(<item:cyclic:crystal_helmet>);
        remove(<item:cyclic:heart>);
        remove(<item:cyclic:heart_empty>);
        remove(<item:cyclic:soulstone>);
        remove(<item:cyclic:charm_ultimate>);
        remove(<item:cyclic:teleport_wand>);
        remove(<item:cyclic:lightning_scepter>);
        remove(<item:cyclic:fire_scepter>);
        remove(<item:cyclic:ice_scepter>);
        remove(<item:cyclic:prospector>);
        remove(<item:cyclic:charm_longfall>);
        remove(<item:cyclic:storage_bag>);
        remove(<item:cyclic:inventory_cake>);
        remove(<item:cyclic:ender_book>);
        remove(<item:cyclic:collector>);
        remove(<item:cyclic:collector_fluid>);
        remove(<item:cyclic:harvester>);
        remove(<item:cyclic:structure>);
        remove(<item:cyclic:miner>);
        remove(<item:cyclic:forester>);
        remove(<item:cyclic:user>);
        remove(<item:cyclic:breaker>);
        remove(<item:cyclic:placer>);
        remove(<item:cyclic:ender_pearl_reuse>);
        remove(<item:cyclic:ender_pearl_mounted>);
        remove(<item:cyclic:charm_home>);
        remove(<item:cyclic:charm_world>);
#rftools
    #items
        #environmental controller
            craftingTable.removeRecipe(<item:rftoolsutility:environmental_controller>);
            craftingTable.addShaped("environmental_controller_edit", <item:rftoolsutility:environmental_controller>, [
                [<item:rftoolsbase:infused_enderpearl>, <item:moremekanismprocessing:tungsten_ingot>, <item:rftoolsbase:infused_enderpearl>],
                [<item:minecraft:diamond_block>, <item:rftoolsbase:machine_frame>, <item:minecraft:diamond_block>],
                [<item:rftoolsbase:infused_enderpearl>, <item:minecraft:netherite_block>, <item:rftoolsbase:infused_enderpearl>]]);
        #cpu
            #500
                craftingTable.removeRecipe(<item:rftoolscontrol:cpu_core_500>);
                craftingTable.addShaped("cpu_500_edit", <item:rftoolscontrol:cpu_core_500>, [
                    [<item:rftoolsbase:dimensionalshard>, <item:engineersdecor:halfslab_sheetmetal_gold>, <item:rftoolsbase:dimensionalshard>],
                    [<item:engineersdecor:halfslab_sheetmetal_gold>, <item:rftoolscontrol:card_base>, <item:engineersdecor:halfslab_sheetmetal_gold>],
                    [<item:rftoolsbase:dimensionalshard>, <item:engineersdecor:halfslab_sheetmetal_gold>, <item:rftoolsbase:dimensionalshard>]]);
            #1000
                craftingTable.removeRecipe(<item:rftoolscontrol:cpu_core_1000>);
                craftingTable.addShaped("cpu_1000_edit", <item:rftoolscontrol:cpu_core_1000>, [
                    [<item:rftoolsutility:redstone_information>, <item:engineersdecor:halfslab_sheetmetal_gold>, <item:rftoolsutility:energy_module>],
                    [<item:engineersdecor:halfslab_sheetmetal_gold>, <item:rftoolscontrol:cpu_core_500>, <item:engineersdecor:halfslab_sheetmetal_gold>],
                    [<item:mekanism:teleportation_core>, <item:engineersdecor:halfslab_sheetmetal_gold>, <item:rftoolscontrol:network_card>]]);
            #2000
                craftingTable.removeRecipe(<item:rftoolscontrol:cpu_core_2000>);
                craftingTable.addShaped("cpu_2000_edit", <item:rftoolscontrol:cpu_core_2000>, [
                    [<item:draconicevolution:draconium_aoe_module>, <item:engineersdecor:halfslab_sheetmetal_gold>, <item:rftoolscontrol:console_module>],
                    [<item:engineersdecor:halfslab_sheetmetal_gold>, <item:rftoolscontrol:cpu_core_1000>, <item:engineersdecor:halfslab_sheetmetal_gold>],
                    [<item:rftoolsutility:flight_module>, <item:engineersdecor:halfslab_sheetmetal_gold>, <item:rftoolsutility:speedplus_module>]]);
        #programmer
            craftingTable.removeRecipe(<item:rftoolscontrol:programmer>);
            craftingTable.addShaped("programmer_rftools_edit", <item:rftoolscontrol:programmer>, [
                [steelPlate, <item:minecraft:quartz>, steelPlate],
                [<item:rftoolscontrol:cpu_core_2000>, <item:rftoolsbase:machine_frame>, <item:rftoolsbase:infused_diamond>],
                [steelPlate, <item:minecraft:quartz>, steelPlate]]);
        #spawner
            craftingTable.removeRecipe(<item:rftoolsutility:spawner>);
            craftingTable.addShaped("spawner_edit", <item:rftoolsutility:spawner>, [
                [ironPlate, steelPlate, ironPlate],
                [ccc, <item:rftoolsbase:machine_frame>, <item:minecraft:redstone_block>],
                [ironPlate, steelPlate, ironPlate]]);
        #machine base
            craftingTable.removeRecipe(<item:rftoolsbase:machine_base>);
            craftingTable.addShaped("machine_base_edit", <item:rftoolsbase:machine_base>, [
                [steelPlate, steelPlate, steelPlate],
                [<tag:items:forge:stone>, <item:kubejs:omega_ingot>, <tag:items:forge:stone>]]);
        #shape card quarry
            craftingTable.removeRecipe(<item:rftoolsbuilder:shape_card_quarry>);
            craftingTable.addShaped("shape_card_quarry_edit", <item:rftoolsbuilder:shape_card_quarry>, [
                [<item:moremekanismprocessing:tungsten_ingot>, <item:kubejs:alloy_chaotic>, <item:moremekanismprocessing:tungsten_ingot>],
                [<item:moremekanismprocessing:tungsten_ingot>, <item:rftoolsbuilder:shape_card_def>, <item:moremekanismprocessing:tungsten_ingot>],
                [<item:moremekanismprocessing:tungsten_ingot>, <item:kubejs:chaotic_control_circuit>, <item:moremekanismprocessing:tungsten_ingot>]]);
        #machine frame
            craftingTable.removeRecipe(<item:rftoolsbase:machine_frame>);
            craftingTable.addShaped("machine_frame_rfools_edit", <item:rftoolsbase:machine_frame>, [
                [steelPlate, <item:kubejs:compressed_obsidian>, steelPlate],
                [<item:rftoolsbase:infused_diamond>, <item:kubejs:alloy_chaotic>, <item:rftoolsbase:infused_diamond>],
                [steelPlate, <item:kubejs:compressed_obsidian>, steelPlate]]);
    #remove
        remove(<item:rftoolsutility:charged_porter>);
        remove(<item:rftoolsutility:advanced_charged_porter>);
#spartan
    #removals
        mods.jei.JEI.hideRegex(".*boomerang.*");
        craftingTable.removeByRegex(".*boomerang.*");
        mods.jei.JEI.hideRegex(".*tomahawk.*");
        craftingTable.removeByRegex(".*tomahawk.*");
        mods.jei.JEI.hideRegex(".*Javelin.*");
        craftingTable.removeByRegex(".*Javelin.*");
        mods.jei.JEI.hideRegex(".*throwing knife.*");
        craftingTable.removeByRegex(".*throwing knife.*");
        remove(<item:spartanweaponry:dynamite>);
        remove(<item:spartanweaponry:arrow_explosive>);
        remove(<item:spartanshields:shield_mekanism_powered_basic>);
        remove(<item:spartanshields:shield_mekanism_powered_advanced>);
        remove(<item:spartanshields:shield_mekanism_powered_elite>);
        remove(<item:spartanshields:shield_mekanism_powered_ultimate>);
        remove(<item:spartanweaponry:explosive_charge>);
    #recipe edit
        Replacer.forMods("spartanweaponry")
            .replace(<item:minecraft:iron_ingot>, <item:immersiveengineering:plate_iron>)
            .replace(<item:minecraft:gold_ingot>, <item:immersiveengineering:plate_gold>)
            .replace(<tag:items:forge:ingots/copper>, <item:immersiveengineering:plate_copper>)
            .replace(<item:minecraft:netherite_ingot>, <item:thermal:netherite_plate>)
            .replace(<tag:items:forge:ingots/tin>, <item:thermal:tin_plate>)
            .replace(<tag:items:forge:ingots/bronze>, <item:thermal:bronze_plate>)
            .replace(<tag:items:forge:ingots/steel>, <item:immersiveengineering:plate_steel>)
            .replace(<tag:items:forge:ingots/silver>, <item:immersiveengineering:plate_silver>)
            .replace(<item:thermal:invar_ingot>, <item:thermal:invar_plate>)
            .replace(<tag:items:forge:ingots/electrum>, <item:immersiveengineering:plate_electrum>)
            .replace(<tag:items:forge:ingots/nickel>, <item:immersiveengineering:plate_nickel>)
            .replace(<tag:items:forge:ingots/lead>, <item:immersiveengineering:plate_lead>)
            .execute();
#immersive engineering
    #press
        #ammo
            <recipetype:immersiveengineering:metal_press>.removeRecipe(<item:immersiveengineering:empty_casing> * 2);
            <recipetype:immersiveengineering:metal_press>.addRecipe("ammo_edit_press", <item:create:brass_block>, <item:immersiveengineering:mold_bullet_casing>, 10000, <item:immersiveengineering:empty_casing>);
    #deleted recipies
        craftingTable.removeRecipe(<item:immersiveengineering:plate_copper>);
        craftingTable.removeRecipe(<item:immersiveengineering:plate_aluminum>);
        craftingTable.removeRecipe(<item:immersiveengineering:plate_lead>);
        craftingTable.removeRecipe(<item:immersiveengineering:plate_silver>);
        craftingTable.removeRecipe(<item:immersiveengineering:plate_nickel>);
        craftingTable.removeRecipe(<item:immersiveengineering:plate_uranium>);
        craftingTable.removeRecipe(<item:immersiveengineering:plate_constantan>);
        craftingTable.removeRecipe(<item:immersiveengineering:plate_electrum>);
        craftingTable.removeRecipe(<item:immersiveengineering:plate_steel>);
        craftingTable.removeRecipe(<item:immersiveengineering:plate_iron>);
        craftingTable.removeRecipe(<item:immersiveengineering:plate_gold>);
        craftingTable.removeRecipe(<item:immersiveengineering:empty_casing>);
        <recipetype:immersiveengineering:alloy>.removeRecipe(<item:create:brass_ingot>);
    #arc furnace
        #steel
            <recipetype:immersiveengineering:arc_furnace>.removeRecipe(<item:immersiveengineering:ingot_steel>);
            <recipetype:immersiveengineering:arc_furnace>.addRecipe("steel_buff_arc", <item:minecraft:iron_ingot> * 1, [<item:immersiveengineering:dust_coke> * 1], 20, 204800, [<item:mekanism:ingot_steel>], <item:immersiveengineering:slag>);
        #removals
            <recipetype:immersiveengineering:arc_furnace>.removeRecipe(<item:create:brass_ingot> * 2);
        #omega
            <recipetype:immersiveengineering:arc_furnace>.addRecipe("omega_ingot_arc", <item:botania:terrasteel_ingot> * 1, [<item:tconstruct:manyullyn_ingot> * 1, <item:thermal:enderium_ingot> * 1], 100, 1000000, [<item:kubejs:omega_ingot>]);
    #items
        #blueprints
            #special bullet
                craftingTable.removeRecipe(<item:immersiveengineering:blueprint>.withTag({blueprint: "specialBullet" as string}));
                craftingTable.addShaped("blueprint_specialbullet_edit", <item:immersiveengineering:blueprint>.withTag({blueprint: "specialBullet" as string}), [
                    [<item:minecraft:gunpowder>, <item:pneumaticcraft:gun_ammo>, <item:minecraft:gunpowder>],
                    [<item:minecraft:blue_dye>, <item:minecraft:blue_dye>, <item:minecraft:blue_dye>],
                    [<item:minecraft:paper>, <item:minecraft:paper>, <item:minecraft:paper>]]);
            #arc furnace bars
                craftingTable.removeRecipe(<item:immersiveengineering:blueprint>.withTag({blueprint: "electrode" as string}));
                craftingTable.addShaped("electrode_blueprint_edit", <item:immersiveengineering:blueprint>.withTag({blueprint: "electrode" as string}), [
                    [<tag:items:forge:rods/allmetal>, <item:immersiveengineering:ingot_hop_graphite>, <tag:items:forge:rods/allmetal>],
                    [<item:minecraft:blue_dye>, <item:minecraft:blue_dye>, <item:minecraft:blue_dye>],
                    [<item:minecraft:paper>, <item:minecraft:paper>, <item:minecraft:paper>]]);
        #kinetic dynamo
            craftingTable.removeRecipe(<item:immersiveengineering:dynamo>);
            craftingTable.addShaped("kinetic_dynamo_edit", <item:immersiveengineering:dynamo>, [
                [<tag:items:forge:storage_blocks/lead>, <item:immersiveengineering:capacitor_lv>, <tag:items:forge:storage_blocks/lead>],
                [<item:minecraft:redstone_block>, <item:immersiveengineering:coil_lv>, <item:minecraft:redstone_block>],
                [ironPlate, ironPlate, ironPlate]]);
        #Capacitors
            #lv
                craftingTable.removeRecipe(<item:immersiveengineering:capacitor_lv>);
                craftingTable.addShaped("lv_capacitor_edit", <item:immersiveengineering:capacitor_lv>, [
                    [<tag:items:forge:treated_wood>, <item:minecraft:leather>, <tag:items:forge:treated_wood>],
                    [steelPlate, <tag:items:forge:storage_blocks/lead>, steelPlate],
                    [<tag:items:forge:treated_wood>, <item:minecraft:redstone_block>, <tag:items:forge:treated_wood>]]);
            #mv
                craftingTable.removeRecipe(<item:immersiveengineering:capacitor_mv>);
                craftingTable.addShaped("mv_capacitor_edit", <item:immersiveengineering:capacitor_mv>, [
                    [<tag:items:forge:treated_wood>, <item:immersiveengineering:capacitor_lv>, <tag:items:forge:treated_wood>],
                    [<item:immersiveengineering:capacitor_lv>, <tag:items:forge:storage_blocks/steel>, <item:immersiveengineering:capacitor_lv>],
                    [<tag:items:forge:treated_wood>, <item:immersiveengineering:capacitor_lv>, <tag:items:forge:treated_wood>]]);
            #hv
                craftingTable.removeRecipe(<item:immersiveengineering:capacitor_hv>);
                craftingTable.addShaped("hv_capacitor_edit", <item:immersiveengineering:capacitor_hv>, [
                    [<tag:items:forge:treated_wood>, <tag:items:forge:storage_blocks/steel>, <tag:items:forge:treated_wood>],
                    [<item:immersiveengineering:capacitor_mv>, <tag:items:forge:storage_blocks/lead>, <item:immersiveengineering:capacitor_mv>],
                    [<tag:items:forge:treated_wood>, <item:minecraft:redstone_block>, <tag:items:forge:treated_wood>]]);
        #ovens
            #reinforced blast
                craftingTable.removeRecipe(<item:immersiveengineering:blastbrick_reinforced>);
                craftingTable.addShaped("blastbrick_reinforced_edit", <item:immersiveengineering:blastbrick_reinforced>, [
                    [air, steelPlate, air],
                    [steelPlate, <item:immersiveengineering:blastbrick>, steelPlate],
                    [air, steelPlate, air]]);
            #coke
                craftingTable.removeRecipe(<item:immersiveengineering:cokebrick>);
                craftingTable.addShaped("coke_brick_edit", <item:immersiveengineering:cokebrick>, [
                    [<item:minecraft:clay>, <item:minecraft:brick>, <item:minecraft:clay>],
                    [<item:minecraft:brick>, <tag:items:forge:sandstone>, <item:minecraft:brick>],
                    [<item:minecraft:clay>, <item:minecraft:brick>, <item:minecraft:clay>]]);
            #blast
                craftingTable.removeRecipe(<item:immersiveengineering:blastbrick>);
                craftingTable.addShaped("blast_brick_edit", <item:immersiveengineering:blastbrick>, [
                    [<item:minecraft:nether_brick>, <item:minecraft:brick>, <item:minecraft:nether_brick>],
                    [<item:minecraft:brick>, <item:minecraft:magma_block>, <item:minecraft:brick>],
                    [<item:minecraft:nether_brick>, <item:minecraft:brick>, <item:minecraft:nether_brick>]]);
            #kiln
                craftingTable.removeRecipe(<item:immersiveengineering:alloybrick>);
                craftingTable.addShaped("alloy_brick_edit", <item:immersiveengineering:alloybrick>, [
                    [<tag:items:forge:sandstone>, <item:minecraft:bricks>, <tag:items:forge:sandstone>],
                    [<item:minecraft:bricks>, <tag:items:forge:sandstone>, <item:minecraft:bricks>],
                    [<tag:items:forge:sandstone>, <item:minecraft:bricks>, <tag:items:forge:sandstone>]]);
        #rods
            #lead
                craftingTable.addShaped("lead_rod", <item:kubejs:lead_rod>*4, [
                    [<tag:items:forge:ingots/lead>],
                    [<tag:items:forge:ingots/lead>]]);
            #silver
                craftingTable.addShaped("silver_rod", <item:kubejs:silver_rod>*4, [
                    [<tag:items:forge:ingots/silver>],
                    [<tag:items:forge:ingots/silver>]]);
            #nickel
                craftingTable.addShaped("nickel_rod", <item:kubejs:nickel_rod>*4, [
                    [<tag:items:forge:ingots/nickel>],
                    [<tag:items:forge:ingots/nickel>]]);
            #uranium
                craftingTable.addShaped("uranium_rod", <item:kubejs:uranium_rod>*4, [
                    [<tag:items:forge:ingots/uranium>],
                    [<tag:items:forge:ingots/uranium>]]);
            #constantan
                craftingTable.addShaped("constantan_rod", <item:kubejs:constantan_rod>*4, [
                    [<tag:items:forge:ingots/constantan>],
                    [<tag:items:forge:ingots/constantan>]]);
            #electrum
                craftingTable.addShaped("electrum_rod", <item:kubejs:electrum_rod>*4, [
                    [<tag:items:forge:ingots/electrum>],
                    [<tag:items:forge:ingots/electrum>]]);
            #gold
                craftingTable.addShaped("gold_rod", <item:createaddition:gold_rod>*4, [
                    [<tag:items:forge:ingots/gold>],
                    [<tag:items:forge:ingots/gold>]]);
            #copper
                craftingTable.addShaped("copper_rod", <item:createaddition:copper_rod>*4, [
                    [<tag:items:forge:ingots/copper>],
                    [<tag:items:forge:ingots/copper>]]);
            #pressing
                <recipetype:immersiveengineering:metal_press>.addRecipe("copper_rod_press", <tag:items:forge:ingots/copper>, <item:immersiveengineering:mold_rod>, 3000, <item:createaddition:copper_rod>*2);
                <recipetype:immersiveengineering:metal_press>.addRecipe("lead_rod_press", <tag:items:forge:ingots/lead>, <item:immersiveengineering:mold_rod>, 3000, <item:kubejs:lead_rod>*2);
                <recipetype:immersiveengineering:metal_press>.addRecipe("silver_rod_press", <tag:items:forge:ingots/silver>, <item:immersiveengineering:mold_rod>, 3000, <item:kubejs:silver_rod>*2);
                <recipetype:immersiveengineering:metal_press>.addRecipe("nickel_rod_press", <tag:items:forge:ingots/nickel>, <item:immersiveengineering:mold_rod>, 3000, <item:kubejs:nickel_rod>*2);
                <recipetype:immersiveengineering:metal_press>.addRecipe("uranium_rod_press", <tag:items:forge:ingots/uranium>, <item:immersiveengineering:mold_rod>, 3000, <item:kubejs:uranium_rod>*2);
                <recipetype:immersiveengineering:metal_press>.addRecipe("constantan_rod_press", <tag:items:forge:ingots/constantan>, <item:immersiveengineering:mold_rod>, 3000, <item:kubejs:constantan_rod>*2);
                <recipetype:immersiveengineering:metal_press>.addRecipe("electrum_rod_press", <tag:items:forge:ingots/electrum>, <item:immersiveengineering:mold_rod>, 3000, <item:kubejs:electrum_rod>*2);
        #conveyor belt
            craftingTable.removeRecipe(<item:immersiveengineering:conveyor_basic>);
            craftingTable.addShaped("conveyor_belt_edit", <item:immersiveengineering:conveyor_basic>, [
                [<item:minecraft:leather>, <item:minecraft:leather>, <item:minecraft:leather>],
                [ironPlate, redstone, ironPlate]]);
        #sheetmetal
            #copper
                craftingTable.removeRecipe(<item:immersiveengineering:sheetmetal_copper>);
                craftingTable.addShaped("copper_sheetmetal_edit", <item:immersiveengineering:sheetmetal_copper>, [
                    [<item:createaddition:copper_rod>, <item:createaddition:copper_rod>, <item:createaddition:copper_rod>],
                    [<item:createaddition:copper_rod>, <item:createaddition:copper_rod>, <item:createaddition:copper_rod>],
                    [<item:createaddition:copper_rod>, <item:createaddition:copper_rod>, <item:createaddition:copper_rod>]]);
            #aluminum
                craftingTable.removeRecipe(<item:immersiveengineering:sheetmetal_aluminum>);
                craftingTable.addShaped("aluminum_sheetmetal_edit", <item:immersiveengineering:sheetmetal_aluminum>, [
                    [<tag:items:forge:rods/aluminum>, <tag:items:forge:rods/aluminum>, <tag:items:forge:rods/aluminum>],
                    [<tag:items:forge:rods/aluminum>, <tag:items:forge:rods/aluminum>, <tag:items:forge:rods/aluminum>],
                    [<tag:items:forge:rods/aluminum>, <tag:items:forge:rods/aluminum>, <tag:items:forge:rods/aluminum>]]);
            #lead
                craftingTable.removeRecipe(<item:immersiveengineering:sheetmetal_lead>);
                craftingTable.addShaped("lead_sheetmetal_edit", <item:immersiveengineering:sheetmetal_lead>, [
                    [<item:kubejs:lead_rod>, <item:kubejs:lead_rod>, <item:kubejs:lead_rod>],
                    [<item:kubejs:lead_rod>, <item:kubejs:lead_rod>, <item:kubejs:lead_rod>],
                    [<item:kubejs:lead_rod>, <item:kubejs:lead_rod>, <item:kubejs:lead_rod>]]);
            #silver
                craftingTable.removeRecipe(<item:immersiveengineering:sheetmetal_silver>);
                craftingTable.addShaped("silver_sheetmetal_edit", <item:immersiveengineering:sheetmetal_silver>, [
                    [<item:kubejs:silver_rod>, <item:kubejs:silver_rod>, <item:kubejs:silver_rod>],
                    [<item:kubejs:silver_rod>, <item:kubejs:silver_rod>, <item:kubejs:silver_rod>],
                    [<item:kubejs:silver_rod>, <item:kubejs:silver_rod>, <item:kubejs:silver_rod>]]);
            #nickel
                craftingTable.removeRecipe(<item:immersiveengineering:sheetmetal_nickel>);
                craftingTable.addShaped("nickel_sheetmetal_edit", <item:immersiveengineering:sheetmetal_nickel>, [
                    [<item:kubejs:nickel_rod>, <item:kubejs:nickel_rod>, <item:kubejs:nickel_rod>],
                    [<item:kubejs:nickel_rod>, <item:kubejs:nickel_rod>, <item:kubejs:nickel_rod>],
                    [<item:kubejs:nickel_rod>, <item:kubejs:nickel_rod>, <item:kubejs:nickel_rod>]]);
            #uranium
                craftingTable.removeRecipe(<item:immersiveengineering:sheetmetal_uranium>);
                craftingTable.addShaped("uranium_sheetmetal_edit", <item:immersiveengineering:sheetmetal_uranium>, [
                    [<item:kubejs:uranium_rod>, <item:kubejs:uranium_rod>, <item:kubejs:uranium_rod>],
                    [<item:kubejs:uranium_rod>, <item:kubejs:uranium_rod>, <item:kubejs:uranium_rod>],
                    [<item:kubejs:uranium_rod>, <item:kubejs:uranium_rod>, <item:kubejs:uranium_rod>]]);
            #constantan
                craftingTable.removeRecipe(<item:immersiveengineering:sheetmetal_constantan>);
                craftingTable.addShaped("constantan_sheetmetal_edit", <item:immersiveengineering:sheetmetal_constantan>, [
                    [<item:kubejs:constantan_rod>, <item:kubejs:constantan_rod>, <item:kubejs:constantan_rod>],
                    [<item:kubejs:constantan_rod>, <item:kubejs:constantan_rod>, <item:kubejs:constantan_rod>],
                    [<item:kubejs:constantan_rod>, <item:kubejs:constantan_rod>, <item:kubejs:constantan_rod>]]);
            #electrum
                craftingTable.removeRecipe(<item:immersiveengineering:sheetmetal_electrum>);
                craftingTable.addShaped("electrum_sheetmetal_edit", <item:immersiveengineering:sheetmetal_electrum>, [
                    [<item:kubejs:electrum_rod>, <item:kubejs:electrum_rod>, <item:kubejs:electrum_rod>],
                    [<item:kubejs:electrum_rod>, <item:kubejs:electrum_rod>, <item:kubejs:electrum_rod>],
                   [<item:kubejs:electrum_rod>, <item:kubejs:electrum_rod>, <item:kubejs:electrum_rod>]]);
            #steel
                craftingTable.removeRecipe(<item:immersiveengineering:sheetmetal_steel>);
                craftingTable.addShaped("steel_sheetmetal_edit", <item:immersiveengineering:sheetmetal_steel>, [
                    [<tag:items:forge:rods/steel>, <tag:items:forge:rods/steel>, <tag:items:forge:rods/steel>],
                    [<tag:items:forge:rods/steel>, <tag:items:forge:rods/steel>, <tag:items:forge:rods/steel>],
                    [<tag:items:forge:rods/steel>, <tag:items:forge:rods/steel>, <tag:items:forge:rods/steel>]]);
            #iron
                craftingTable.removeRecipe(<item:immersiveengineering:sheetmetal_iron>);
                craftingTable.addShaped("iron_sheetmetal_edit", <item:immersiveengineering:sheetmetal_iron>, [
                    [<tag:items:forge:rods/iron>, <tag:items:forge:rods/iron>, <tag:items:forge:rods/iron>],
                    [<tag:items:forge:rods/iron>, <tag:items:forge:rods/iron>, <tag:items:forge:rods/iron>],
                    [<tag:items:forge:rods/iron>, <tag:items:forge:rods/iron>, <tag:items:forge:rods/iron>]]);
            #gold
                craftingTable.removeRecipe(<item:immersiveengineering:sheetmetal_gold>);
                craftingTable.addShaped("gold_sheetmetal_edit", <item:immersiveengineering:sheetmetal_gold>, [
                    [<item:createaddition:gold_rod>, <item:createaddition:gold_rod>, <item:createaddition:gold_rod>],
                    [<item:createaddition:gold_rod>, <item:createaddition:gold_rod>, <item:createaddition:gold_rod>],
                    [<item:createaddition:gold_rod>, <item:createaddition:gold_rod>, <item:createaddition:gold_rod>]]);
        #plate
            #iron
                craftingTable.addShapeless("iron_plate_edit", <item:immersiveengineering:plate_iron>, 
                    [<item:immersiveengineering:hammer>.anyDamage(), <item:immersiveengineering:sheetmetal_iron>]);
            #copper
                craftingTable.addShapeless("copper_plate_edit", <item:immersiveengineering:plate_copper>, 
                    [<item:immersiveengineering:hammer>.anyDamage(), <item:immersiveengineering:sheetmetal_copper>]);
            #gold
                craftingTable.addShapeless("gold_plate_edit", <item:immersiveengineering:plate_gold>, 
                    [<item:immersiveengineering:hammer>.anyDamage(), <item:immersiveengineering:sheetmetal_gold>]);
            #steel
                craftingTable.addShapeless("steel_plate_edit", <item:immersiveengineering:plate_steel>, 
                    [<item:immersiveengineering:hammer>.anyDamage(), <item:immersiveengineering:sheetmetal_steel>]);
            #electrum
                craftingTable.addShapeless("electrum_plate_edit", <item:immersiveengineering:plate_electrum>, 
                    [<item:immersiveengineering:hammer>.anyDamage(), <item:immersiveengineering:sheetmetal_electrum>]);
            #constantan
                craftingTable.addShapeless("constantan_plate_edit", <item:immersiveengineering:plate_constantan>, 
                    [<item:immersiveengineering:hammer>.anyDamage(), <item:immersiveengineering:sheetmetal_constantan>]);
            #uranium
                craftingTable.addShapeless("uranium_plate_edit", <item:immersiveengineering:plate_uranium>, 
                    [<item:immersiveengineering:hammer>.anyDamage(), <item:immersiveengineering:sheetmetal_uranium>]);
            #nickel
                craftingTable.addShapeless("nickel_plate_edit", <item:immersiveengineering:plate_nickel>, 
                    [<item:immersiveengineering:hammer>.anyDamage(), <item:immersiveengineering:sheetmetal_nickel>]);
            #silver
                craftingTable.addShapeless("silver_plate_edit", <item:immersiveengineering:plate_silver>, 
                    [<item:immersiveengineering:hammer>.anyDamage(), <item:immersiveengineering:sheetmetal_silver>]);
            #lead
                craftingTable.addShapeless("lead_plate_edit", <item:immersiveengineering:plate_lead>, 
                    [<item:immersiveengineering:hammer>.anyDamage(), <item:immersiveengineering:sheetmetal_lead>]);
            #aluminum
                craftingTable.addShapeless("aluminum_plate_edit", <item:immersiveengineering:plate_aluminum>, 
                    [<item:immersiveengineering:hammer>.anyDamage(), <item:immersiveengineering:sheetmetal_aluminum>]);
            #bulk
                <recipetype:immersiveengineering:metal_press>.addRecipe("brass_sheet_press", <tag:items:forge:ingots/brass>, <item:immersiveengineering:mold_plate>, 3000, <item:create:brass_sheet>);
                <recipetype:immersiveengineering:metal_press>.addRecipe("zinc_sheet_press", <tag:items:forge:ingots/zinc>, <item:immersiveengineering:mold_plate>, 3000, <item:createdeco:zinc_sheet>);
                <recipetype:immersiveengineering:metal_press>.addRecipe("signalum_plate_press", <tag:items:forge:ingots/signalum>, <item:immersiveengineering:mold_plate>, 3000, <item:thermal:signalum_plate>);
                <recipetype:immersiveengineering:metal_press>.addRecipe("netherite_plate_press", <item:minecraft:netherite_ingot>, <item:immersiveengineering:mold_plate>, 3000, <item:thermal:netherite_plate>);
                <recipetype:immersiveengineering:metal_press>.addRecipe("lumium_plate_press", <tag:items:forge:ingots/lumium>, <item:immersiveengineering:mold_plate>, 3000, <item:thermal:lumium_plate>);
                <recipetype:immersiveengineering:metal_press>.addRecipe("enderium_plate_press", <tag:items:forge:ingots/enderium>, <item:immersiveengineering:mold_plate>, 3000, <item:thermal:enderium_plate>);
#create
    #mechanical crafter
        #tungsten ingot
            craftingTable.removeRecipe(<item:moremekanismprocessing:tungsten_ingot>);
            <recipetype:create:mechanical_crafting>.addRecipe("tungsten_ingot_mechanical", <item:moremekanismprocessing:tungsten_ingot> * 4, [
                [<item:immersiveengineering:ingot_hop_graphite>, copperPlate, aluminumPlate, leadPlate, invarPlate],
                [nickelPlate, uraniumPlate, constantanPlate, electrumPlate, steelPlate],
                [goldPlate, netheritePlate, brassPlate, bronzePlate, tinPlate],
                [<item:draconicevolution:draconium_ingot>, <item:botania:manasteel_ingot>, ironPlate, silverPlate, <item:tconstruct:repair_kit>.withTag({Material: "tconstruct:plated_slimewood" as string})],
                [<item:mekanism:hdpe_sheet>, zincPlate, signalumPlate, <item:powah:blank_card>, <item:forbidden_arcanus:obsidian_ingot>]
            ]);
        #hand of ender
            craftingTable.removeRecipe(<item:botania:ender_hand>);
            <recipetype:create:mechanical_crafting>.addRecipe("ender_hand_mechanical", <item:botania:ender_hand>, [
                [air, air, air, air, air, ech, air, air, air, air, air],
                [air, air, air, air, ech, ech, ech, air, air, air, air],
                [air, air, air, ech, ech, ech, ech, ech, air, air, air],
                [air, air, ech, ech, ech, ech, ech, ech, ech, air, air],
                [air, ech, ech, ech, ech, cob, cob, cob, ech, ech, air],
                [ech, ech, ech, ech, cob, cob, ccc, cob, cob, ech, ech],
                [air, ech, ech, ech, cob, ccc, rec, ccc, cob, ech, ech],
                [air, air, ech, ech, cob, cob, ccc, cob, cob, ech, ech],
                [air, air, air, ech, ech, cob, cob, cob, ech, ech, air],
                [air, air, air, air, ech, ech, ech, ech, ech, air, air],
                [air, air, air, air, air, ech, ech, ech, air, air, air]
            ]);
        #eternal stella
            craftingTable.removeRecipe(<item:forbidden_arcanus:eternal_stella>);
            <recipetype:create:mechanical_crafting>.addRecipe("eternal_stella_mechanical", <item:forbidden_arcanus:eternal_stella>, [
                [air, <item:forbidden_arcanus:xpetrified_orb>, <item:forbidden_arcanus:xpetrified_orb>, <item:forbidden_arcanus:xpetrified_orb>, air],
                [<item:forbidden_arcanus:xpetrified_orb>, <item:forbidden_arcanus:stellarite_piece>, <item:forbidden_arcanus:stellarite_piece>, <item:forbidden_arcanus:stellarite_piece>, <item:forbidden_arcanus:xpetrified_orb>],
                [<item:forbidden_arcanus:xpetrified_orb>, <item:forbidden_arcanus:stellarite_piece>, <item:draconicevolution:large_chaos_frag>, <item:forbidden_arcanus:stellarite_piece>, <item:forbidden_arcanus:xpetrified_orb>],
                [<item:forbidden_arcanus:xpetrified_orb>, <item:forbidden_arcanus:stellarite_piece>, <item:forbidden_arcanus:stellarite_piece>, <item:forbidden_arcanus:stellarite_piece>, <item:forbidden_arcanus:xpetrified_orb>],
                [air, <item:forbidden_arcanus:xpetrified_orb>, <item:forbidden_arcanus:xpetrified_orb>, <item:forbidden_arcanus:xpetrified_orb>, air]
            ]);
        #heart core
            <recipetype:create:mechanical_crafting>.addRecipe("heart_core_mechanical", <item:lifesteal:heart_core>, [
                [air, air, core, core, air, core, core, air, air],
                [air, core, core, core, core, core, core, core, air],
                [core, core, core, core, core, core, core, core, core],
                [core, core, core, core, core, core, core, core, core],
                [air, core, core, core, core, core, core, core, air],
                [air, air, core, core, core, core, core, air, air],
                [air, air, air, core, core, core, air, air, air],
                [air, air, air, air, core, air, air, air, air]]);
        #diamond heart
            <recipetype:create:mechanical_crafting>.addRecipe("diamond_heart_mechanical", <item:quark:diamond_heart>, [
                [air, air, steelPlate, air, air],
                [air, steelPlate, <item:minecraft:diamond_block>, steelPlate, air],
                [steelPlate, <item:minecraft:diamond_block>, <item:lifesteal:heart_core>, <item:minecraft:diamond_block>, steelPlate],
                [air, steelPlate, <item:minecraft:diamond_block>, steelPlate, air],
                [air, air, steelPlate, air, air]
                ]);
        #crushing wheels
            <recipetype:create:mechanical_crafting>.removeRecipe(<item:create:crushing_wheel>);
            <recipetype:create:mechanical_crafting>.addRecipe("crushing_wheel_mechanical_edit", <item:create:crushing_wheel> * 2, [
                [air, <item:create:andesite_alloy>, <item:create:andesite_alloy>, <item:create:andesite_alloy>, <item:create:andesite_alloy>, <item:create:andesite_alloy>, air],
                [<item:create:andesite_alloy>, <item:create:andesite_alloy>, <tag:items:minecraft:planks>, <tag:items:minecraft:planks>, <tag:items:minecraft:planks>, <item:create:andesite_alloy>, <item:create:andesite_alloy>],
                [<item:create:andesite_alloy>, <tag:items:minecraft:planks>, <tag:items:minecraft:planks>, <tag:items:forge:stone>, <tag:items:minecraft:planks>, <tag:items:minecraft:planks>, <item:create:andesite_alloy>],
                [<item:create:andesite_alloy>, <tag:items:minecraft:planks>, <tag:items:forge:stone>, <item:kubejs:compressed_obsidian>, <tag:items:forge:stone>, <tag:items:minecraft:planks>, <item:create:andesite_alloy>],
                [<item:create:andesite_alloy>, <tag:items:minecraft:planks>, <tag:items:minecraft:planks>, <tag:items:forge:stone>, <tag:items:minecraft:planks>, <tag:items:minecraft:planks>, <item:create:andesite_alloy>],
                [<item:create:andesite_alloy>, <item:create:andesite_alloy>, <tag:items:minecraft:planks>, <tag:items:minecraft:planks>, <tag:items:minecraft:planks>, <item:create:andesite_alloy>, <item:create:andesite_alloy>],
                [air,<item:create:andesite_alloy>, <item:create:andesite_alloy>, <item:create:andesite_alloy>, <item:create:andesite_alloy>, <item:create:andesite_alloy>,  air]
                ]);
        #motor
            <recipetype:create:mechanical_crafting>.removeRecipe(<item:createaddition:electric_motor>);
            <recipetype:create:mechanical_crafting>.addRecipe("electric_motor_mechanical_edit", <item:createaddition:electric_motor>, [
                [air, brassPlate, <item:createaddition:copper_spool>, brassPlate, air],
                [brassPlate, <item:createaddition:copper_spool>, <item:create:andesite_alloy>, <item:createaddition:copper_spool>, brassPlate],
                [<item:createaddition:copper_spool>, <item:create:andesite_alloy>, <item:create:precision_mechanism>, <item:create:andesite_alloy>, <item:createaddition:copper_spool>],
                [brassPlate, <item:createaddition:copper_spool>, <item:createaddition:capacitor>, <item:createaddition:copper_spool>, brassPlate],
                [air, brassPlate, <item:createaddition:copper_spool>, brassPlate, air]
            ]);
        #alternator
            <recipetype:create:mechanical_crafting>.removeRecipe(<item:createaddition:alternator>);
            <recipetype:create:mechanical_crafting>.addRecipe("alternator_mechanical_edit", <item:createaddition:alternator>, [
                [air, ironPlate, <item:createaddition:copper_spool>, ironPlate, air],
                [ironPlate, <item:createaddition:copper_spool>, <item:create:andesite_alloy>, <item:createaddition:copper_spool>, ironPlate],
                [<item:createaddition:copper_spool>, <item:create:andesite_alloy>, <item:create:precision_mechanism>, <item:create:andesite_alloy>, <item:createaddition:copper_spool>],
                [ironPlate, <item:createaddition:copper_spool>, <item:createaddition:capacitor>, <item:createaddition:copper_spool>, ironPlate],
                [air, ironPlate, <item:createaddition:copper_spool>, ironPlate, air]
                ]);
        #extendo grip
            <recipetype:create:mechanical_crafting>.removeRecipe(<item:create:extendo_grip>);
            <recipetype:create:mechanical_crafting>.addRecipe("extendo_grip_edit", <item:create:extendo_grip>, [
                [air, <item:create:brass_block>, air],
                [<item:create:precision_mechanism>, ccc, <item:create:precision_mechanism>],
                [brassPlate, <item:minecraft:ladder>, brassPlate],
                [brassPlate, <item:minecraft:ladder>, brassPlate],
                [brassPlate, <item:minecraft:ladder>, brassPlate],
                [brassPlate, <item:minecraft:ladder>, brassPlate],
                [brassPlate, <item:minecraft:ladder>, brassPlate],
                [brassPlate, <item:minecraft:ladder>, brassPlate],
                [brassPlate, <item:minecraft:ladder>, brassPlate],
                [brassPlate, <item:minecraft:ladder>, brassPlate],
                [brassPlate, <item:minecraft:ladder>, brassPlate],
                [brassPlate, <item:minecraft:ladder>, brassPlate],
                [air, <item:create:brass_hand>, air]
            ]);
    #sequenced assembly
        #dielectric paste
            craftingTable.removeRecipe(<item:create:blaze_cake_base>);
            <recipetype:create:sequenced_assembly>.addRecipe(<recipetype:create:sequenced_assembly>.builder("dielectric_paste_lava_sequenced")
                .transitionTo(<item:botania:cosmetic_eyepatch>)
                .require(<item:minecraft:clay_ball>)
                .loops(2)
                .addOutput(<item:powah:dielectric_paste> * 24, 1)
                .addStep(<recipetype:create:filling>.factory(), (rb) => rb.require(<fluid:minecraft:lava> * 500))
                .addStep(<recipetype:create:deploying>.factory(), (rb) => rb.require(<tag:items:minecraft:coals>)));
            <recipetype:create:sequenced_assembly>.addRecipe(<recipetype:create:sequenced_assembly>.builder("dielectric_paste_blaze_sequenced")
                .transitionTo(<item:botania:cosmetic_eyepatch>)
                .require(<item:minecraft:clay_ball>)
                .loops(2)
                .addOutput(<item:powah:dielectric_paste> * 24, 1)
                .addStep(<recipetype:create:deploying>.factory(), (rb) => rb.require(<item:minecraft:blaze_powder>))
                .addStep(<recipetype:create:deploying>.factory(), (rb) => rb.require(<tag:items:minecraft:coals>)));
        #blaze cake base
            <recipetype:create:compacting>.removeRecipe(<item:create:blaze_cake_base>);
            <recipetype:create:sequenced_assembly>.addRecipe(<recipetype:create:sequenced_assembly>.builder("blaze_cake_base_sequenced")
                .transitionTo(<item:create:cinder_flour>)
                .require(<item:create:cinder_flour>)
                .loops(2)
                .addOutput(<item:create:blaze_cake_base>, 1)
                .addStep(<recipetype:create:deploying>.factory(), (rb) => rb.require(<item:minecraft:sugar>))
                .addStep(<recipetype:create:deploying>.factory(), (rb) => rb.require(<tag:items:forge:eggs>))
                .addStep(<recipetype:create:deploying>.factory(), (rb) => rb.require(<item:create:cinder_flour>))
                .addStep(<recipetype:create:filling>.factory(), (rb) => rb.require(<fluid:minecraft:lava> * 2000)));
        #cogwheel
            #small
                <recipetype:create:sequenced_assembly>.removeByName("create:sequenced_assembly/cogwheel");
                <recipetype:create:sequenced_assembly>.addRecipe(<recipetype:create:sequenced_assembly>.builder("small_cogwhell_sequence")
                    .transitionTo(<item:minecraft:spruce_pressure_plate>)
                    .require(<item:create:andesite_alloy>)
                    .loops(10)
                    .addOutput(<item:create:cogwheel> * 10, 26)
                    .addOutput(<item:create:andesite_alloy>, 1)
                    .addOutput(<item:create:precision_mechanism>, 1)
                    .addOutput(<item:minecraft:spruce_pressure_plate>, 1)
                    .addOutput(<item:colossalchests:chest_wall_wood>, 1)
                    .addStep(<recipetype:create:deploying>.factory(), (rb) => rb.require(<tag:items:minecraft:wooden_buttons>))
                    .addStep(<recipetype:create:deploying>.factory(), (rb) => rb.require(<tag:items:minecraft:planks>)));
            #large
                <recipetype:create:sequenced_assembly>.removeByName("create:sequenced_assembly/large_cogwheel");
                <recipetype:create:sequenced_assembly>.addRecipe(<recipetype:create:sequenced_assembly>.builder("large_cogwhell_sequence")
                    .transitionTo(<item:minecraft:spruce_pressure_plate>)
                    .require(<item:create:andesite_alloy>)
                    .loops(8)
                    .addOutput(<item:create:large_cogwheel> * 8, 26)
                    .addOutput(<item:create:cogwheel> * 5, 1)
                    .addOutput(<item:create:precision_mechanism>, 1)
                    .addOutput(<item:minecraft:spruce_pressure_plate>, 1)
                    .addOutput(<item:colossalchests:chest_wall_wood>, 1)
                    .addStep(<recipetype:create:deploying>.factory(), (rb) => rb.require(<tag:items:minecraft:logs>))
                    .addStep(<recipetype:create:cutting>.factory(), (rb) => rb.duration(500)));
        #ultimate control circuit
            <recipetype:create:sequenced_assembly>.addRecipe(<recipetype:create:sequenced_assembly>.builder("ultimate_control_circuit")
                .transitionTo(<item:kubejs:chaotic_control_circuit_incomplete>)
                .require(<item:mekanism:ultimate_control_circuit>)
                .loops(2)
                .addOutput(<item:kubejs:chaotic_control_circuit>, 80)
                .addOutput(<item:kubejs:alloy_chaotic>, 5)
                .addOutput(<item:mekanism:ultimate_control_circuit>, 5)
                .addOutput(<item:minecraft:nether_star>, 5)
                .addOutput(<item:computercraft:computer_advanced>, 4)
                .addOutput(<item:kubejs:reactor_core>, 1)
                .addStep(<recipetype:create:deploying>.factory(), (rb) => rb.require(<item:kubejs:alloy_chaotic>))
                .addStep(<recipetype:create:deploying>.factory(), (rb) => rb.require(<item:draconicevolution:awakened_core>))
                .addStep(<recipetype:create:cutting>.factory(), (rb) => rb.duration(5000))
                .addStep(<recipetype:create:deploying>.factory(), (rb) => rb.require(<item:pneumaticcraft:advanced_pcb>))
                .addStep(<recipetype:create:deploying>.factory(), (rb) => rb.require(<item:moremekanismprocessing:tungsten_ingot>))
                .addStep(<recipetype:create:pressing>.factory(), (rb) => rb.duration(1000)));
    #items
        #electron tube
            craftingTable.removeRecipe(<item:create:electron_tube>);
            craftingTable.addShaped("electron_tube_edit", <item:create:electron_tube>, [
                [<item:create:polished_rose_quartz>],
                [<item:minecraft:redstone_torch>],
                [ironPlate]]);
        #mechanical crafter
            craftingTable.removeRecipe(<item:create:mechanical_crafter> * 3);
            craftingTable.addShaped("mechanical_crafter_edit", <item:create:mechanical_crafter>, [
                [<item:create:electron_tube>, <item:create:precision_mechanism>, <item:create:electron_tube>],
                [<item:create:cogwheel>, <item:create:brass_casing>, <item:create:cogwheel>],
                [air, <item:minecraft:crafting_table>, air]]);
        #sail
            #empty
                craftingTable.removeRecipe(<item:create:sail_frame>);
                craftingTable.addShaped("sail_frame_edit", <item:create:sail_frame> * 2, [
                    [<item:minecraft:stick>, <item:minecraft:stick>, <item:minecraft:stick>],
                    [<item:minecraft:stick>, <item:create:andesite_alloy>, <item:minecraft:stick>],
                    [<item:minecraft:stick>, <item:minecraft:stick>, <item:minecraft:stick>]]);
            #filled
                craftingTable.removeRecipe(<item:create:white_sail>);
                craftingTable.addShaped("white_sail_edit", <item:create:white_sail>, [
                    [<item:create:sail_frame>, <item:minecraft:stick>],
                    [<item:minecraft:stick>, <tag:items:minecraft:wool>]]);
        #capacitor
            craftingTable.removeRecipe(<item:createaddition:capacitor>);
            craftingTable.addShaped("capacitor_edit", <item:createaddition:capacitor>, [
                [zincPlate, zincPlate, zincPlate],
                [ironPlate, <item:immersiveengineering:current_transformer>, ironPlate],
                [ironPlate, <item:minecraft:redstone_torch>, ironPlate]]);
        #spool
            craftingTable.removeRecipe(<item:createaddition:spool>);
            craftingTable.addShaped("spool_edit", <item:createaddition:spool>, [
                [ironPlate],
                [<tag:items:forge:rods/iron>],
                [ironPlate]]);
        #blaze cake
            <recipetype:create:filling>.removeRecipe(<item:create:blaze_cake>);
            craftingTable.addShaped("blaze_cake_edit", <item:create:blaze_cake>, [
                [<item:minecraft:blaze_rod>, lumiumPlate, <item:minecraft:blaze_rod>],
                [lumiumPlate, <item:create:blaze_cake_base>, lumiumPlate],
                [<item:minecraft:blaze_rod>, lumiumPlate, <item:minecraft:blaze_rod>]]);
        #fluid tank
            craftingTable.removeRecipe(<item:create:fluid_tank>);
            craftingTable.addShaped("fluid_tank_edit", <item:create:fluid_tank>, [
                [<item:create:copper_casing>, <item:create:copper_casing>, <item:create:copper_casing>],
                [copperPlate, <tag:items:forge:glass>, copperPlate],
                [<item:create:copper_casing>, <item:create:copper_casing>, <item:create:copper_casing>]]);
        #blaze burner
            craftingTable.removeRecipe(<item:create:empty_blaze_burner>);
            craftingTable.addShaped("empty_blaze_burner_edit", <item:create:empty_blaze_burner>, [
                [ironPlate, ironPlate, ironPlate],
                [<item:minecraft:iron_bars>, <item:minecraft:iron_bars>, <item:minecraft:iron_bars>],
                [steelPlate, steelPlate, steelPlate]]);
        #shaft
            craftingTable.removeRecipe(<item:create:shaft>);
            craftingTable.addShaped("shaft_edit", <item:create:shaft> * 3, [
                [leadPlate, <item:create:andesite_alloy>, leadPlate],
                [leadPlate, <item:create:andesite_alloy>, leadPlate],
                [leadPlate, <item:create:andesite_alloy>, leadPlate]]);
        #cog
            #small
                craftingTable.removeRecipe(<item:create:cogwheel>);
                craftingTable.addShapeless("small_cogwheel_edit", <item:create:cogwheel>, [<item:create:andesite_alloy>, <item:create:shaft>, <tag:items:minecraft:logs>]);
            #large
                craftingTable.removeRecipe(<item:create:large_cogwheel>);
                craftingTable.addShapeless("large_cogwheel_edit", <item:create:large_cogwheel>, [<item:create:andesite_alloy>, <item:create:cogwheel>, <tag:items:minecraft:logs>]);
        #casing
            #copper
                craftingTable.removeRecipe(<item:create:copper_casing>);
                craftingTable.addShaped("copper_casing_edit", <item:create:copper_casing>, [
                    [copperPlate, leadPlate, copperPlate],
                    [leadPlate, <tag:items:forge:storage_blocks/tin>, leadPlate],
                    [copperPlate, leadPlate, copperPlate]]);
            #andesite
                craftingTable.removeRecipe(<item:create:andesite_casing>);
                craftingTable.addShaped("andesite_casing_edit", <item:create:andesite_casing>, [
                    [<item:create:andesite_alloy>, <tag:items:minecraft:logs>, <item:create:andesite_alloy>],
                    [<tag:items:minecraft:logs>, <item:minecraft:iron_block>, <tag:items:minecraft:logs>],
                    [<item:create:andesite_alloy>, <tag:items:minecraft:logs>, <item:create:andesite_alloy>]]);
            #brass
                craftingTable.removeRecipe(<item:create:brass_casing>);
                craftingTable.addShaped("brass_casing_edit", <item:create:brass_casing>, [
                    [<item:create:brass_sheet>, <tag:items:minecraft:logs>, <item:create:brass_sheet>],
                    [<tag:items:minecraft:logs>, <tag:items:forge:storage_blocks/steel>, <tag:items:minecraft:logs>],
                    [<item:create:brass_sheet>, <tag:items:minecraft:logs>, <item:create:brass_sheet>]]);
        #encased shaft
            #andesite
                craftingTable.removeRecipe(<item:create:andesite_encased_shaft>);
                craftingTable.addShapeless("andesite_encased_shaft_edit", <item:create:andesite_encased_shaft>, [<item:create:shaft>, <item:create:andesite_casing>]);
            #brass
                craftingTable.removeRecipe(<item:create:brass_encased_shaft>);
                craftingTable.addShapeless("brass_encased_shaft_edit", <item:create:brass_encased_shaft>, [<item:create:shaft>, <item:create:brass_casing>]);
        #andesite alloy
            craftingTable.removeRecipe(<item:create:andesite_alloy>);
            craftingTable.addShaped("andesite_alloy_edit", <item:create:andesite_alloy>, [
                [<item:kubejs:compressed_andesite>, <item:pneumaticcraft:ingot_iron_compressed>],
                [<item:pneumaticcraft:ingot_iron_compressed>, <item:kubejs:compressed_andesite>]]);
    #pressing
        #plates
            #iron
                <recipetype:create:pressing>.removeRecipe(<item:create:iron_sheet>);
                <recipetype:create:pressing>.addRecipe("iron_sheet_edit", [<item:immersiveengineering:plate_iron>], <item:minecraft:iron_ingot>);
            #copper
                <recipetype:create:pressing>.removeRecipe(<item:create:copper_sheet>);
                <recipetype:create:pressing>.addRecipe("copper_sheet_edit", [<item:immersiveengineering:plate_copper>], <tag:items:forge:ingots/copper>);
            #gold
                <recipetype:create:pressing>.removeRecipe(<item:create:golden_sheet>);
                <recipetype:create:pressing>.addRecipe("gold_sheet_edit", [<item:immersiveengineering:plate_gold>], <item:minecraft:gold_ingot>);
            #netherite
                <recipetype:create:pressing>.removeRecipe(<item:createdeco:netherite_sheet>);
                <recipetype:create:pressing>.addRecipe("netherite_sheet_edit", [<item:thermal:netherite_plate>], <item:minecraft:netherite_ingot>);
            #bulk additions
                <recipetype:create:pressing>.addRecipe("aluminum_plate_create", [<item:immersiveengineering:plate_aluminum>], <tag:items:forge:ingots/aluminum>);
                <recipetype:create:pressing>.addRecipe("lead_plate_create", [<item:immersiveengineering:plate_lead>], <tag:items:forge:ingots/lead>);
                <recipetype:create:pressing>.addRecipe("silver_plate_create", [<item:immersiveengineering:plate_silver>], <tag:items:forge:ingots/silver>);
                <recipetype:create:pressing>.addRecipe("nickel_plate_create", [<item:immersiveengineering:plate_nickel>], <tag:items:forge:ingots/nickel>);
                <recipetype:create:pressing>.addRecipe("uranium_plate_create", [<item:immersiveengineering:plate_uranium>], <tag:items:forge:ingots/uranium>);
                <recipetype:create:pressing>.addRecipe("constantan_plate_create", [<item:immersiveengineering:plate_constantan>], <tag:items:forge:ingots/constantan>);
                <recipetype:create:pressing>.addRecipe("electrum_plate_create", [<item:immersiveengineering:plate_electrum>], <tag:items:forge:ingots/electrum>);
                <recipetype:create:pressing>.addRecipe("steel_plate_create", [<item:immersiveengineering:plate_steel>], <tag:items:forge:ingots/steel>);
                <recipetype:create:pressing>.addRecipe("tin_plate_create", [<item:thermal:tin_plate>], <tag:items:forge:ingots/tin>);
                <recipetype:create:pressing>.addRecipe("bronze_plate_create", [<item:thermal:bronze_plate>], <tag:items:forge:ingots/bronze>);
                <recipetype:create:pressing>.addRecipe("invar_plate_create", [<item:thermal:invar_plate>], <tag:items:forge:ingots/invar>);
                <recipetype:create:pressing>.addRecipe("signalum_plate_create", [<item:thermal:signalum_plate>], <tag:items:forge:ingots/signalum>);
                <recipetype:create:pressing>.addRecipe("lumium_plate_create", [<item:thermal:lumium_plate>], <tag:items:forge:ingots/lumium>);
                <recipetype:create:pressing>.addRecipe("enderium_plate_create", [<item:thermal:enderium_plate>], <tag:items:forge:ingots/enderium>);
    #hide
        mods.jei.JEI.hideItem(<item:create_stuff_additions:tuned_brass_moped_item>);
        smithing.removeRecipe(<item:create_stuff_additions:tuned_brass_moped_item>);
        mods.jei.JEI.hideItem(<item:create:copper_sheet>);
        mods.jei.JEI.hideItem(<item:create:iron_sheet>);
        mods.jei.JEI.hideItem(<item:create:golden_sheet>);
        mods.jei.JEI.hideItem(<item:createdeco:zinc_sheet>);
        <recipetype:create:pressing>.removeRecipe(<item:createdeco:zinc_sheet>);
        mods.jei.JEI.hideItem(<item:createdeco:netherite_sheet>);
#thermal
    #induction
        #quartz iron
            <recipetype:thermal:smelter>.removeRecipe([<item:refinedstorage:quartz_enriched_iron>]);
            <recipetype:thermal:smelter>.addRecipe("quartz_iron_induction_edit", [<item:refinedstorage:quartz_enriched_iron> * 4], [<tag:items:forge:dusts/quartz>|<item:minecraft:quartz>*4, <item:minecraft:iron_ingot> * 4], 3, 2000);
        #brass
            <recipetype:thermal:smelter>.removeRecipe([<item:create:brass_ingot>]);
            <recipetype:thermal:smelter>.addRecipe("brass_induction_edit", [<item:create:brass_ingot>], [<item:create:zinc_block>, <tag:items:forge:storage_blocks/copper>], 3, 2000);
    #items
        #ingots
            #signalum
                #ingot
                    craftingTable.removeRecipe(<item:thermal:signalum_ingot>);
                #dust
                    craftingTable.removeRecipe(<item:thermal:signalum_dust>);
                #tinkers
                    <recipetype:tconstruct:alloying>.removeRecipe(<fluid:tconstruct:molten_signalum>);
                    <recipetype:tconstruct:alloying>.addRecipe("signalum_alloy_edit", [<fluid:tconstruct:molten_netherite> * 144, <fluid:tconstruct:molten_copper> * 1296, <fluid:tconstruct:molten_silver> * 432, <fluid:thermal:redstone> * 600], <fluid:tconstruct:molten_signalum> * 144, 950);
                #induction
                    <recipetype:thermal:smelter>.removeRecipe([<item:thermal:signalum_ingot>]);
            #lumium
                #ingot
                    craftingTable.removeRecipe(<item:thermal:lumium_ingot>);
                #dust
                    craftingTable.removeRecipe(<item:thermal:lumium_dust>);
                #tinkers
                    <recipetype:tconstruct:alloying>.removeRecipe(<fluid:tconstruct:molten_lumium>);
                    <recipetype:tconstruct:alloying>.addRecipe("lumium_alloy_edit", [<fluid:tconstruct:molten_signalum> * 144, <fluid:tconstruct:molten_tin> * 1296, <fluid:tconstruct:molten_silver> * 432, <fluid:thermal:glowstone> * 1000], <fluid:tconstruct:molten_lumium> * 144, 1050);
                #induction
                    <recipetype:thermal:smelter>.removeRecipe([<item:thermal:lumium_ingot>]);
            #enderium
                #ingot
                    craftingTable.removeRecipe(<item:thermal:enderium_ingot>);
                #dust
                    craftingTable.removeRecipe(<item:thermal:enderium_dust>);
                #tinkers
                    <recipetype:tconstruct:alloying>.removeRecipe(<fluid:tconstruct:molten_enderium>);
                    <recipetype:tconstruct:alloying>.addRecipe("enderium_alloy_edit", [<fluid:tconstruct:molten_lumium> * 144, <fluid:tconstruct:molten_diamond> * 288, <fluid:tconstruct:molten_lead> * 1296, <fluid:tconstruct:molten_ender> * 500], <fluid:tconstruct:molten_enderium> * 144, 1350);
                #induction
                    <recipetype:thermal:smelter>.removeRecipe([<item:thermal:enderium_ingot>]);
        #xp crystal
            craftingTable.removeRecipe(<item:thermal:xp_crystal>);
            craftingTable.addShaped("insightful_crystal_edit", <item:thermal:xp_crystal>, [
                [air, <item:minecraft:lapis_block>, air],
                [<item:minecraft:emerald_block>, <item:minecraft:experience_bottle>, <item:minecraft:emerald_block>],
                [air, <item:minecraft:lapis_block>, air]]);
        #augments
            #speed
                craftingTable.removeRecipe(<item:thermal:machine_speed_augment>);
                craftingTable.addShaped("flux_linkage_amplifier_edit", <item:thermal:machine_speed_augment>, [
                    [<tag:items:forge:storage_blocks/steel>, <item:thermal:lead_gear>, <tag:items:forge:storage_blocks/steel>],
                    [electrumPlate, <item:thermal:rf_coil>, electrumPlate],
                    [<tag:items:forge:storage_blocks/steel>, <item:thermal:lead_gear>, <tag:items:forge:storage_blocks/steel>]]);
            #fluid
                craftingTable.removeRecipe(<item:thermal:fluid_tank_augment>);
                craftingTable.addShaped("fluid_tank_augment_edit", <item:thermal:fluid_tank_augment>, [
                    [<item:thermal:cured_rubber>, ironPlate, <item:thermal:cured_rubber>],
                    [ironPlate, <item:mekanism:basic_fluid_tank>, ironPlate],
                    [<item:thermal:cured_rubber>, ironPlate, <item:thermal:cured_rubber>]]);
            #rf
                #standard
                    craftingTable.removeRecipe(<item:thermal:rf_coil_augment>);
                    craftingTable.addShaped("rf_coil_augment_edit", <item:thermal:rf_coil_augment>, [
                        [air, <item:minecraft:gold_block>, air],
                        [<tag:items:forge:storage_blocks/silver>, <item:thermal:rf_coil>, <tag:items:forge:storage_blocks/silver>],
                        [air, <item:minecraft:gold_block>, air]]);
                #storage
                    craftingTable.removeRecipe(<item:thermal:rf_coil_storage_augment>);
                    craftingTable.addShaped("rf_coil_storage_augment_edit", <item:thermal:rf_coil_storage_augment>, [
                        [air, <tag:items:forge:storage_blocks/silver>, air],
                        [<item:minecraft:gold_block>, <item:thermal:rf_coil>, <item:minecraft:gold_block>],
                        [air, <item:minecraft:gold_block>, air]]);
                #transfer
                    craftingTable.removeRecipe(<item:thermal:rf_coil_xfer_augment>);
                    craftingTable.addShaped("rf_coil_xfer_augment_edit", <item:thermal:rf_coil_xfer_augment>, [
                        [air, <tag:items:forge:storage_blocks/silver>, air],
                        [<tag:items:forge:storage_blocks/silver>, <item:thermal:rf_coil>, <tag:items:forge:storage_blocks/silver>],
                        [air, <item:minecraft:gold_block>, air]]);
            #integral
                #t1
                    craftingTable.removeRecipe(<item:thermal:upgrade_augment_1>);
                    craftingTable.addShaped("upgrade_augment_1_edit", <item:thermal:upgrade_augment_1>, [
                        [invarPlate, <item:thermal:tin_gear>, invarPlate],
                        [<item:minecraft:redstone_block>, <item:thermal:gold_gear>, <item:minecraft:redstone_block>],
                        [invarPlate, <item:thermal:tin_gear>, invarPlate]]);
                #t2
                    craftingTable.removeRecipe(<item:thermal:upgrade_augment_2>);
                    craftingTable.addShaped("upgrade_augment_2_edit", <item:thermal:upgrade_augment_2>, [
                        [electrumPlate, <item:thermal:quartz_gear>, electrumPlate],
                        [<item:thermal:signalum_gear>, <item:thermal:upgrade_augment_1>, <item:thermal:signalum_gear>],
                        [electrumPlate, <item:thermal:quartz_gear>, electrumPlate]]);
                #t3
                    craftingTable.removeRecipe(<item:thermal:upgrade_augment_3>);
                    craftingTable.addShaped("upgrade_augment_3_edit", <item:thermal:upgrade_augment_3>, [
                        [enderiumPlate, <item:thermal:netherite_gear>, enderiumPlate],
                        [<item:thermal:lumium_gear>, <item:thermal:upgrade_augment_2>, <item:thermal:lumium_gear>],
                        [enderiumPlate, <item:thermal:netherite_gear>, enderiumPlate]]);
        #redstone servo
            craftingTable.removeRecipe(<item:thermal:redstone_servo>);
            craftingTable.addShaped("redstone_servo_edit", <item:thermal:redstone_servo>, [
                [redstone, ironPlate, redstone],
                [<item:minecraft:air>, steelPlate, <item:minecraft:air>],
                [redstone, ironPlate, redstone]]);
        #redstone flux coil
            craftingTable.removeRecipe(<item:thermal:rf_coil>);
            craftingTable.addShaped("rf_coil_edit", <item:thermal:rf_coil>, [
                [<item:minecraft:gold_nugget>, <item:minecraft:air>, goldPlate],
                [<item:minecraft:air>, <item:minecraft:redstone_block>, <item:minecraft:air>],
                [goldPlate, <item:minecraft:air>, <item:minecraft:gold_nugget>]]);
        #machine frame
            craftingTable.removeRecipe(<item:thermal:machine_frame>);
            craftingTable.addShaped("machine_frame_thermal_edit", <item:thermal:machine_frame>, [
                [ironPlate, <item:thermal:tin_gear>, ironPlate],
                [<item:thermal:tin_gear>, <item:immersiveengineering:alu_scaffolding_standard>, <item:thermal:tin_gear>],
                [ironPlate, <item:thermal:tin_gear>, ironPlate]]);
        #gears
            #iron
                craftingTable.removeRecipe(<item:thermal:iron_gear>);
                craftingTable.addShaped("iron_gear_edit", <item:thermal:iron_gear>, [
                    [air, ironPlate, air],
                    [ironPlate, <item:minecraft:iron_nugget>, ironPlate],
                    [air, ironPlate, air]]);
            #gold
                craftingTable.removeRecipe(<item:thermal:gold_gear>);
                craftingTable.addShaped("gold_gear_edit", <item:thermal:gold_gear>, [
                    [air, goldPlate, air],
                    [goldPlate, <item:minecraft:iron_nugget>, goldPlate],
                    [air, goldPlate, air]]);
            #netherite
                craftingTable.removeRecipe(<item:thermal:netherite_gear>);
                craftingTable.addShaped("netherite_gear_edit", <item:thermal:netherite_gear>, [
                    [air, netheritePlate, air],
                    [netheritePlate, <item:minecraft:iron_nugget>, netheritePlate],
                    [air, netheritePlate, air]]);
            #copper
                craftingTable.removeRecipe(<item:thermal:copper_gear>);
                craftingTable.addShaped("copper_gear_edit", <item:thermal:copper_gear>, [
                    [air, copperPlate, air],
                    [copperPlate, <item:minecraft:iron_nugget>, copperPlate],
                    [air, copperPlate, air]]);
            #tin
                craftingTable.removeRecipe(<item:thermal:tin_gear>);
                craftingTable.addShaped("tin_gear_edit", <item:thermal:tin_gear>, [
                    [air, tinPlate, air],
                    [tinPlate, <item:minecraft:iron_nugget>, tinPlate],
                    [air, tinPlate, air]]);
            #lead
                craftingTable.removeRecipe(<item:thermal:lead_gear>);
                craftingTable.addShaped("lead_gear_edit", <item:thermal:lead_gear>, [
                    [air, leadPlate, air],
                    [leadPlate, <item:minecraft:iron_nugget>, leadPlate],
                    [air, leadPlate, air]]);
            #silver
                craftingTable.removeRecipe(<item:thermal:silver_gear>);
                craftingTable.addShaped("silver_gear_edit", <item:thermal:silver_gear>, [
                    [air, silverPlate, air],
                    [silverPlate, <item:minecraft:iron_nugget>, silverPlate],
                    [air, silverPlate, air]]);
            #nickel
                craftingTable.removeRecipe(<item:thermal:nickel_gear>);
                craftingTable.addShaped("nickel_gear_edit", <item:thermal:nickel_gear>, [
                    [air, nickelPlate, air],
                    [nickelPlate, <item:minecraft:iron_nugget>, nickelPlate],
                    [air, nickelPlate, air]]);
            #bronze
                craftingTable.removeRecipe(<item:thermal:bronze_gear>);
                craftingTable.addShaped("bronze_gear_edit", <item:thermal:bronze_gear>, [
                    [air, bronzePlate, air],
                    [bronzePlate, <item:minecraft:iron_nugget>, bronzePlate],
                    [air, bronzePlate, air]]);
            #electrum
                craftingTable.removeRecipe(<item:thermal:electrum_gear>);
                craftingTable.addShaped("electrum_gear_edit", <item:thermal:electrum_gear>, [
                    [air, electrumPlate, air],
                    [electrumPlate, <item:minecraft:iron_nugget>, electrumPlate],
                    [air, electrumPlate, air]]);
            #invar
                craftingTable.removeRecipe(<item:thermal:invar_gear>);
                craftingTable.addShaped("invar_gear_edit", <item:thermal:invar_gear>, [
                    [air, invarPlate, air],
                    [invarPlate, <item:minecraft:iron_nugget>, invarPlate],
                    [air, invarPlate, air]]);
            #constantan
                craftingTable.removeRecipe(<item:thermal:constantan_gear>);
                craftingTable.addShaped("constantan_gear_edit", <item:thermal:constantan_gear>, [
                    [air, constantanPlate, air],
                    [constantanPlate, <item:minecraft:iron_nugget>, constantanPlate],
                    [air, constantanPlate, air]]);
            #signalum
                craftingTable.removeRecipe(<item:thermal:signalum_gear>);
                craftingTable.addShaped("signalum_gear_edit", <item:thermal:signalum_gear>, [
                    [air, signalumPlate, air],
                    [signalumPlate, <item:minecraft:iron_nugget>, signalumPlate],
                    [air, signalumPlate, air]]);
            #lumium
                craftingTable.removeRecipe(<item:thermal:lumium_gear>);
                craftingTable.addShaped("lumium_gear_edit", <item:thermal:lumium_gear>, [
                    [air, lumiumPlate, air],
                    [lumiumPlate, <item:minecraft:iron_nugget>, lumiumPlate],
                    [air, lumiumPlate, air]]);
            #enderium
                craftingTable.removeRecipe(<item:thermal:enderium_gear>);
                craftingTable.addShaped("enderium_gear_edit", <item:thermal:enderium_gear>, [
                    [air, enderiumPlate, air],
                    [enderiumPlate, <item:minecraft:iron_nugget>, enderiumPlate],
                    [air, enderiumPlate, air]]);
    #press
        #plates
            #copper
                mods.jei.JEI.hideItem(<item:thermal:copper_plate>);
                <recipetype:thermal:press>.removeRecipe(<item:thermal:copper_plate>);
                <recipetype:thermal:press>.addRecipe("copper_plate_addition", [<item:immersiveengineering:plate_copper>], <fluid:minecraft:empty>, [<tag:items:forge:ingots/copper>], 2400);
            #iron
                mods.jei.JEI.hideItem(<item:thermal:iron_plate>);
                <recipetype:thermal:press>.removeRecipe(<item:thermal:iron_plate>);
                <recipetype:thermal:press>.addRecipe("iron_plate_addition", [<item:immersiveengineering:plate_iron>], <fluid:minecraft:empty>, [<tag:items:forge:ingots/iron>], 2400);
            #gold
                mods.jei.JEI.hideItem(<item:thermal:gold_plate>);
                <recipetype:thermal:press>.removeRecipe(<item:thermal:gold_plate>);
                <recipetype:thermal:press>.addRecipe("gold_plate_addition", [<item:immersiveengineering:plate_gold>], <fluid:minecraft:empty>, [<tag:items:forge:ingots/gold>], 2400);
            #lead
                mods.jei.JEI.hideItem(<item:thermal:lead_plate>);
                <recipetype:thermal:press>.removeRecipe(<item:thermal:lead_plate>);
                <recipetype:thermal:press>.addRecipe("lead_plate_addition", [<item:immersiveengineering:plate_lead>], <fluid:minecraft:empty>, [<tag:items:forge:ingots/lead>], 2400);
            #silver
                mods.jei.JEI.hideItem(<item:thermal:silver_plate>);
                <recipetype:thermal:press>.removeRecipe(<item:thermal:silver_plate>);
                <recipetype:thermal:press>.addRecipe("silver_plate_addition", [<item:immersiveengineering:plate_silver>], <fluid:minecraft:empty>, [<tag:items:forge:ingots/silver>], 2400);
            #nickel
                mods.jei.JEI.hideItem(<item:thermal:nickel_plate>);
                <recipetype:thermal:press>.removeRecipe(<item:thermal:nickel_plate>);
                <recipetype:thermal:press>.addRecipe("nickel_plate_addition", [<item:immersiveengineering:plate_nickel>], <fluid:minecraft:empty>, [<tag:items:forge:ingots/nickel>], 2400);
            #electrum
                mods.jei.JEI.hideItem(<item:thermal:electrum_plate>);
                <recipetype:thermal:press>.removeRecipe(<item:thermal:electrum_plate>);
                <recipetype:thermal:press>.addRecipe("electrum_plate_addition", [<item:immersiveengineering:plate_electrum>], <fluid:minecraft:empty>, [<tag:items:forge:ingots/electrum>], 2400);
                mods.jei.JEI.hideItem(<item:thermal:constantan_plate>);
            #bulk
                <recipetype:thermal:press>.removeRecipe(<item:thermal:constantan_plate>);
                <recipetype:thermal:press>.addRecipe("constantan_plate_addition", [<item:immersiveengineering:plate_constantan>], <fluid:minecraft:empty>, [<tag:items:forge:ingots/constantan>], 2400);
                <recipetype:thermal:press>.addRecipe("aluminum_plate_addition", [<item:immersiveengineering:plate_aluminum>], <fluid:minecraft:empty>, [<tag:items:forge:ingots/aluminum>], 2400);
                <recipetype:thermal:press>.addRecipe("steel_plate_addition", [<item:immersiveengineering:plate_steel>], <fluid:minecraft:empty>, [<tag:items:forge:ingots/steel>], 2400);
                <recipetype:thermal:press>.addRecipe("brass_sheet_addition", [<item:create:brass_sheet>], <fluid:minecraft:empty>, [<tag:items:forge:ingots/brass>], 2400);
                <recipetype:thermal:press>.addRecipe("zinc_sheet_addition", [<item:createaddition:zinc_sheet>], <fluid:minecraft:empty>, [<tag:items:forge:ingots/zinc>], 2400);
    #removals
        remove(<item:thermal:explosive_grenade>);
        remove(<item:thermal:fire_grenade>);
        remove(<item:thermal:lightning_grenade>);
        remove(<item:thermal:ender_grenade>);
        remove(<item:thermal:earth_grenade>);
        remove(<item:thermal:earth_tnt>);
        remove(<item:thermal:earth_tnt_minecart>);
        remove(<item:thermal:fire_tnt_minecart>);
        remove(<item:thermal:earth_tnt>);
#archers paradox
    remove(<item:archers_paradox:explosive_arrow>);
    remove(<item:archers_paradox:displacement_arrow>);
    remove(<item:archers_paradox:ender_arrow>);
#quark
    #items
        #rope
            craftingTable.removeRecipe(<item:quark:rope>);
            craftingTable.addShaped("rope_edit", <item:quark:rope>, [
                [<item:minecraft:string>, <item:minecraft:string>],
                [<item:minecraft:string>, <item:minecraft:string>],
                [<item:minecraft:string>, <item:minecraft:string>]]);
    #removals
        remove(<item:quark:backpack>);
#simply backpacks
    #recipes
        #common
            craftingTable.removeRecipe(<item:simplybackpacks:commonbackpack>);
            craftingTable.addShaped("common_backpack_edit", <item:simplybackpacks:commonbackpack>, [
                [<item:minecraft:white_wool>, <item:quark:bonded_leather>, <item:minecraft:white_wool>],
                [<item:quark:rope>, <tag:items:forge:chests>, <item:quark:rope>],
                [<item:minecraft:white_wool>, <item:quark:bonded_leather>, <item:minecraft:white_wool>]]);
        #uncommon
            craftingTable.removeRecipe(<item:simplybackpacks:uncommonbackpack>);
            craftingTable.addShaped("uncommon_backpack_edit", <item:simplybackpacks:uncommonbackpack>, [
                [<item:minecraft:gold_block>, <tag:items:forge:chests>, <item:minecraft:gold_block>],
                [<tag:items:forge:dyes/yellow>, <item:simplybackpacks:commonbackpack>, <tag:items:forge:dyes/yellow>],
                [<item:minecraft:gold_block>, <tag:items:forge:chests>, <item:minecraft:gold_block>]]);
        #rare
            craftingTable.removeRecipe(<item:simplybackpacks:rarebackpack>);
            craftingTable.addShaped("rare_backpack_edit", <item:simplybackpacks:rarebackpack>, [
                [<item:minecraft:diamond_block>, <tag:items:forge:chests>, <item:minecraft:diamond_block>],
                [<tag:items:forge:dyes/blue>, <item:simplybackpacks:uncommonbackpack>, <tag:items:forge:dyes/blue>],
                [<item:minecraft:diamond_block>, <tag:items:forge:chests>, <item:minecraft:diamond_block>]]);
        #epic
            craftingTable.removeRecipe(<item:simplybackpacks:epicbackpack>);
            craftingTable.addShaped("epic_backpack_edit", <item:simplybackpacks:epicbackpack>, [
                [<item:mekanism:block_refined_obsidian>, <item:minecraft:ender_chest>, <item:mekanism:block_refined_obsidian>],
                [<tag:items:forge:dyes/purple>, <item:simplybackpacks:rarebackpack>, <tag:items:forge:dyes/purple>],
                [<item:mekanism:block_refined_obsidian>, <item:minecraft:ender_chest>, <item:mekanism:block_refined_obsidian>]]);
    #removals
        remove(<item:simplybackpacks:ultimatebackpack>);
#building gadgets
    #items
        #paste
            #t1
                craftingTable.removeRecipe(<item:buildinggadgets:construction_paste_container_t1>);
                craftingTable.addShaped("paste_container_t1_edit", <item:buildinggadgets:construction_paste_container_t1>, [
                    [ironPlate, ironPlate, ironPlate],
                    [ironPlate, <item:buildinggadgets:construction_paste>, ironPlate],
                    [ironPlate, ironPlate, ironPlate]]);
            #t2
                craftingTable.removeRecipe(<item:buildinggadgets:construction_paste_container_t2>);
                craftingTable.addShaped("paste_container_t2_edit", <item:buildinggadgets:construction_paste_container_t2>, [
                    [<item:buildinggadgets:construction_paste_container_t1>, goldPlate, <item:buildinggadgets:construction_paste_container_t1>],
                    [goldPlate, <item:minecraft:gold_block>, goldPlate],
                    [<item:buildinggadgets:construction_paste_container_t1>, goldPlate, <item:buildinggadgets:construction_paste_container_t1>]]);
            #t3
                craftingTable.removeRecipe(<item:buildinggadgets:construction_paste_container_t3>);
                craftingTable.addShaped("paste_container_t3_edit", <item:buildinggadgets:construction_paste_container_t3>, [
                    [<item:buildinggadgets:construction_paste_container_t2>, <item:minecraft:diamond>, <item:buildinggadgets:construction_paste_container_t2>],
                    [<item:minecraft:diamond>, <item:minecraft:diamond_block>, <item:minecraft:diamond>],
                    [<item:buildinggadgets:construction_paste_container_t2>, <item:minecraft:diamond>, <item:buildinggadgets:construction_paste_container_t2>]]);
        #standard
            craftingTable.removeRecipe(<item:buildinggadgets:gadget_building>);
            craftingTable.addShaped("building_gadget_edit", <item:buildinggadgets:gadget_building>, [
                [<item:minecraft:ender_pearl>, <tag:items:forge:storage_blocks/tin>, <item:minecraft:ender_pearl>],
                [ironPlate, <item:minecraft:redstone_block>, ironPlate],
                [ironPlate, <item:buildinggadgets:construction_paste>, ironPlate]]);
        #exchanging
            craftingTable.removeRecipe(<item:buildinggadgets:gadget_exchanging>);
            craftingTable.addShaped("exchanging_gadget_edit", <item:buildinggadgets:gadget_exchanging>, [
                [<item:minecraft:lapis_block>, <tag:items:forge:storage_blocks/tin>, <item:minecraft:lapis_block>],
                [ironPlate, <item:buildinggadgets:gadget_building>, ironPlate],
                [ironPlate, ironPlate, ironPlate]]);
        #copy
            craftingTable.removeRecipe(<item:buildinggadgets:gadget_copy_paste>);
            craftingTable.addShaped("copy_paste_gadget_edit", <item:buildinggadgets:gadget_copy_paste>, [
                [<item:buildinggadgets:construction_paste_container_t1>, <tag:items:forge:storage_blocks/tin>, <item:buildinggadgets:construction_paste_container_t1>],
                [ironPlate, <item:buildinggadgets:gadget_building>, ironPlate],
                [ironPlate, ironPlate, ironPlate]]);
        #destruction
            craftingTable.removeRecipe(<item:buildinggadgets:gadget_destruction>);
            craftingTable.addShaped("destruction_gadget_edit", <item:buildinggadgets:gadget_destruction>, [
                [<item:minecraft:tnt>, <tag:items:forge:storage_blocks/tin>, <item:minecraft:tnt>],
                [steelPlate, <item:buildinggadgets:gadget_building>, steelPlate],
                [steelPlate, steelPlate, steelPlate]]);
#colossal chest
    #items
        #wood
            craftingTable.removeRecipe(<item:colossalchests:chest_wall_wood>);
            craftingTable.addShaped("chest_wall_wood", <item:colossalchests:chest_wall_wood>, [
                [<item:cfm:oak_crate>, <item:cfm:oak_crate>, <item:cfm:oak_crate>],
                [<item:cfm:oak_crate>, <item:forbidden_arcanus:wax>, <item:cfm:oak_crate>],
                [<item:cfm:oak_crate>, <item:cfm:oak_crate>, <item:cfm:oak_crate>]]);
        #iron
            craftingTable.removeRecipe(<item:colossalchests:chest_wall_iron>);
            craftingTable.addShaped("chest_wall_iron", <item:colossalchests:chest_wall_iron>, [
                [<item:tconstruct:manyullyn_ingot>, <tag:items:forge:storage_blocks/iron>, <item:tconstruct:manyullyn_ingot>],
                [<item:colossalchests:chest_wall_wood>, <item:forbidden_arcanus:wax>, <item:colossalchests:chest_wall_wood>],
                [<item:tconstruct:manyullyn_ingot>, <tag:items:forge:storage_blocks/iron>, <item:tconstruct:manyullyn_ingot>]]);
        #gold
            craftingTable.removeRecipe(<item:colossalchests:chest_wall_gold>);
            craftingTable.addShaped("chest_wall_gold", <item:colossalchests:chest_wall_gold>, [
                [<item:moremekanismprocessing:tungsten_ingot>, <tag:items:forge:storage_blocks/gold>, <item:moremekanismprocessing:tungsten_ingot>],
                [<item:colossalchests:chest_wall_iron>, <item:forbidden_arcanus:wax>, <item:colossalchests:chest_wall_iron>],
                [<item:moremekanismprocessing:tungsten_ingot>, <tag:items:forge:storage_blocks/gold>, <item:moremekanismprocessing:tungsten_ingot>]]);
        #diamond
            craftingTable.removeRecipe(<item:colossalchests:chest_wall_diamond>);
            craftingTable.addShaped("chest_wall_diamond", <item:colossalchests:chest_wall_diamond>, [
                [<item:kubejs:alloy_chaotic>, <tag:items:forge:storage_blocks/diamond>, <item:kubejs:alloy_chaotic>],
                [<item:colossalchests:chest_wall_gold>, <item:forbidden_arcanus:wax>, <item:colossalchests:chest_wall_gold>],
                [<item:kubejs:alloy_chaotic>, <tag:items:forge:storage_blocks/diamond>, <item:kubejs:alloy_chaotic>]]);
    #removals
        remove(<item:colossalchests:upgrade_tool>);
        remove(<item:colossalchests:upgrade_tool_reverse>);
        remove(<item:colossalchests:colossal_chest_obsidian>);
        remove(<item:colossalchests:interface_obsidian>);
        remove(<item:colossalchests:chest_wall_obsidian>);
        remove(<item:colossalchests:colossal_chest_silver>);
        remove(<item:colossalchests:interface_silver>);
        remove(<item:colossalchests:chest_wall_silver>);
        remove(<item:colossalchests:colossal_chest_copper>);
        remove(<item:colossalchests:interface_copper>);
        remove(<item:colossalchests:chest_wall_copper>);
#flux
    #hide
        mods.jei.JEI.hideItem(<item:fluxnetworks:flux_dust>);
    #items
        #storage basic
            craftingTable.removeRecipe(<item:fluxnetworks:basic_flux_storage>);
            craftingTable.addShaped("basic_flux_storage_edit", <item:fluxnetworks:basic_flux_storage>, [
                [<item:fluxnetworks:flux_block>, <item:fluxnetworks:flux_block>, <item:fluxnetworks:flux_block>],
                [<tag:items:forge:glass_panes>, <item:kubejs:omega_dust>, <tag:items:forge:glass_panes>],
                [<item:fluxnetworks:flux_block>, <item:fluxnetworks:flux_block>, <item:fluxnetworks:flux_block>]]);
        #block
            craftingTable.removeRecipe(<item:fluxnetworks:flux_block>);
        #core
            craftingTable.removeRecipe(<item:fluxnetworks:flux_core>);
            craftingTable.addShaped("flux_core_edit", <item:fluxnetworks:flux_core>, [
                [<item:fluxnetworks:flux_dust>, <item:minecraft:obsidian>, <item:fluxnetworks:flux_dust>],
                [<item:minecraft:obsidian>, <item:minecraft:ender_eye>, <item:minecraft:obsidian>],
                [<item:fluxnetworks:flux_dust>, <item:minecraft:obsidian>, <item:fluxnetworks:flux_dust>]]);
        #controller
            craftingTable.removeRecipe(<item:fluxnetworks:flux_controller>);
            craftingTable.addShaped("flux_controller_edit", <item:fluxnetworks:flux_controller>, [
                [<item:fluxnetworks:flux_block>, <item:fluxnetworks:flux_block>, <item:fluxnetworks:flux_block>],
                [<item:fluxnetworks:flux_dust>, air, <item:fluxnetworks:flux_dust>],
                [<item:fluxnetworks:flux_block>, <item:fluxnetworks:flux_block>, <item:fluxnetworks:flux_block>]]);
        #configurator
            craftingTable.removeRecipe(<item:fluxnetworks:flux_configurator>);
            craftingTable.addShaped("flux_configurator_edit", <item:fluxnetworks:flux_configurator>, [
                [air, <item:fluxnetworks:flux_dust>, <item:minecraft:ender_eye>],
                [air, <item:minecraft:obsidian>, <item:fluxnetworks:flux_dust>],
                [<item:minecraft:obsidian>, air, air]]);
#pneumaticcraft
    #explosion
        #add
            <recipetype:pneumaticcraft:explosion_crafting>.addRecipe("compressed_iron_block_explosion", <tag:items:forge:storage_blocks/iron>, [<item:kubejs:compressed_iron_block>], 75);
        #remove
            <recipetype:pneumaticcraft:explosion_crafting>.removeRecipe(<item:pneumaticcraft:compressed_iron_block>);   
    #pressure chamber
        #compressed obsidian
            <recipetype:pneumaticcraft:pressure_chamber>.addRecipe("obsidian_compressed_pressure", [<item:minecraft:obsidian> * 64], [<item:kubejs:compressed_obsidian>], 5.0);
        #compressed andesite
            <recipetype:pneumaticcraft:pressure_chamber>.addRecipe("anedsite_compressed_pressure", [<item:minecraft:andesite> * 2], [<item:kubejs:compressed_andesite>], 2.0);
        #turbine blade
            <recipetype:pneumaticcraft:pressure_chamber>.removeRecipe(<item:pneumaticcraft:turbine_blade>);
            <recipetype:pneumaticcraft:pressure_chamber>.addRecipe("turbine_blade_edit", [<item:pneumaticcraft:ingot_iron_compressed> * 4, steelPlate * 4, redstone], [<item:pneumaticcraft:turbine_blade>], 1.5);
        #chaotic dust
            <recipetype:pneumaticcraft:pressure_chamber>.addRecipe("omega_dust_pressure", [<item:kubejs:omega_ingot>], [<item:kubejs:omega_dust> * 2], 5.0);
        #flux
            <recipetype:pneumaticcraft:pressure_chamber>.addRecipe("flux_dust_test", [redstone], [<item:fluxnetworks:flux_dust>], 2.5);
    #assembly station
        #flux
            <recipetype:pneumaticcraft:assembly_laser>.addRecipe("flux_dust_assembly", redstone * 3, <item:fluxnetworks:flux_dust> * 4);
        #flux block
            <recipetype:pneumaticcraft:assembly_drill>.addRecipe("flux_block", <item:fluxnetworks:flux_core> * 8, <item:fluxnetworks:flux_block>);
    #items
        #programmer
            craftingTable.removeRecipe(<item:pneumaticcraft:programmer>);
            craftingTable.addShaped("programmer_pncr_edit", <item:pneumaticcraft:programmer>, [
                [<item:minecraft:red_dye>, <tag:items:forge:glass_panes/black>, <item:minecraft:red_dye>],
                [<item:pneumaticcraft:printed_circuit_board>, <item:pneumaticcraft:turbine_rotor>, <item:rftoolscontrol:cpu_core_2000>],
                [<item:pneumaticcraft:plastic>, air, <item:pneumaticcraft:plastic>]]);
        #jackhammer
            craftingTable.removeRecipe(<item:pneumaticcraft:jackhammer>);
            craftingTable.addShaped("jackhammer_edit", <item:pneumaticcraft:jackhammer>, [
                [<item:pneumaticcraft:plastic>, <item:kubejs:compressed_iron_block>, <item:pneumaticcraft:plastic>],
                [<item:pneumaticcraft:ingot_iron_compressed>, <item:pneumaticcraft:pressure_tube>, <item:pneumaticcraft:ingot_iron_compressed>],                    [<item:minecraft:diamond>, cylinder, <item:minecraft:diamond>]]);
        #heat pipe
            craftingTable.removeRecipe(<item:pneumaticcraft:heat_pipe>);
            craftingTable.addShaped("heat_pipe_edit", <item:pneumaticcraft:heat_pipe>, [
                [<item:pneumaticcraft:thermal_lagging>, <item:pneumaticcraft:thermal_lagging>, <item:pneumaticcraft:thermal_lagging>],
                [<item:kubejs:compressed_iron_block>, <item:kubejs:compressed_iron_block>, <item:kubejs:compressed_iron_block>],
                [<item:pneumaticcraft:thermal_lagging>, <item:pneumaticcraft:thermal_lagging>, <item:pneumaticcraft:thermal_lagging>]]);
        #compressed blocks edits
            #old chamber
                <recipetype:pneumaticcraft:pressure_chamber>.removeRecipe(<item:pneumaticcraft:compressed_iron_block>);
            #new chamber
                <recipetype:pneumaticcraft:pressure_chamber>.addRecipe("compressed_iron_block_new_pressure", [<item:pneumaticcraft:ingot_iron_compressed> * 9], [<item:kubejs:compressed_iron_block>], 4.0);
            #old recipe
                craftingTable.removeRecipe(<item:pneumaticcraft:compressed_iron_block>);
                craftingTable.addShaped("old_compressed_block_edit", <item:pneumaticcraft:compressed_iron_block>, [
                    [<item:kubejs:compressed_iron_block>, <item:kubejs:compressed_iron_block>, <item:kubejs:compressed_iron_block>],
                    [<item:kubejs:compressed_iron_block>, <item:kubejs:compressed_iron_block>, <item:kubejs:compressed_iron_block>],
                    [<item:kubejs:compressed_iron_block>, <item:kubejs:compressed_iron_block>, <item:kubejs:compressed_iron_block>]]);
            #new recipe
                craftingTable.addShaped("new_compressed_block", <item:kubejs:compressed_iron_block>, [
                    [<item:pneumaticcraft:ingot_iron_compressed>, <item:pneumaticcraft:ingot_iron_compressed>, <item:pneumaticcraft:ingot_iron_compressed>],
                    [<item:pneumaticcraft:ingot_iron_compressed>, <item:pneumaticcraft:ingot_iron_compressed>, <item:pneumaticcraft:ingot_iron_compressed>],
                    [<item:pneumaticcraft:ingot_iron_compressed>, <item:pneumaticcraft:ingot_iron_compressed>, <item:pneumaticcraft:ingot_iron_compressed>]]);
            #new to ingot
                craftingTable.addShapeless("new_compressed_to_ingot", <item:pneumaticcraft:ingot_iron_compressed> * 9, [<item:kubejs:compressed_iron_block>]);
            #old to ingot
                craftingTable.removeByName("pneumaticcraft:compressed_iron_ingot_from_block");
        #gear
            craftingTable.removeRecipe(<item:pneumaticcraft:compressed_iron_gear>);
            craftingTable.addShaped("compressed_iron_gear_edit", <item:pneumaticcraft:compressed_iron_gear>, [
                [air, <item:pneumaticcraft:ingot_iron_compressed>, air],
                [<item:kubejs:compressed_iron_block>, <item:minecraft:iron_nugget>, <item:kubejs:compressed_iron_block>],
                [air, <item:pneumaticcraft:ingot_iron_compressed>, air]]);
        #ammo
            craftingTable.removeRecipe(<item:pneumaticcraft:gun_ammo>);
            craftingTable.addShaped("minigun_ammo_edit", <item:pneumaticcraft:gun_ammo> * 2, [
                [<item:immersiveengineering:empty_casing>, <item:immersiveengineering:empty_casing>, <item:immersiveengineering:empty_casing>],
                [<item:immersiveengineering:empty_casing>, <item:pneumaticcraft:compressed_iron_block>, <item:immersiveengineering:empty_casing>],
                [<item:immersiveengineering:empty_casing>, <item:immersiveengineering:empty_casing>, <item:immersiveengineering:empty_casing>]]);
        #assembly items
            #laser
                craftingTable.removeRecipe(<item:pneumaticcraft:assembly_laser>);
                craftingTable.addShaped("assembly_laser_edit", <item:pneumaticcraft:assembly_laser>, [
                    [<tag:items:forge:glass/red>, cylinder, cylinder],
                    [air, air, cylinder],
                    [<item:kubejs:compressed_iron_block>, <item:pneumaticcraft:printed_circuit_board>, <item:kubejs:compressed_iron_block>]]);
            #drill
                craftingTable.removeRecipe(<item:pneumaticcraft:assembly_drill>);
                craftingTable.addShaped("assembly_drill_edit", <item:pneumaticcraft:assembly_drill>, [
                    [<item:minecraft:diamond>, cylinder, cylinder],
                    [air, air, cylinder],
                    [<item:kubejs:compressed_iron_block>, <item:pneumaticcraft:printed_circuit_board>, <item:kubejs:compressed_iron_block>]]);
            #platform
                craftingTable.removeRecipe(<item:pneumaticcraft:assembly_platform>);
                craftingTable.addShaped("assembly_platform_edit", <item:pneumaticcraft:assembly_platform>, [
                    [cylinder, cylinder, cylinder],
                    [<item:pneumaticcraft:plastic>, <item:pneumaticcraft:plastic>, <item:pneumaticcraft:plastic>],
                    [<item:kubejs:compressed_iron_block>, <item:pneumaticcraft:printed_circuit_board>, <item:kubejs:compressed_iron_block>]]);
            #IO
                #import
                    craftingTable.removeRecipe(<item:pneumaticcraft:assembly_io_unit_import>);
                    craftingTable.addShaped("assembly_io_unit_import_edit", <item:pneumaticcraft:assembly_io_unit_import>, [
                        [<item:create:brass_hand>, cylinder, cylinder],
                        [air, air, cylinder],
                        [<item:kubejs:compressed_iron_block>, <item:pneumaticcraft:printed_circuit_board>, <item:kubejs:compressed_iron_block>]]);
                #export
                    craftingTable.removeRecipe(<item:pneumaticcraft:assembly_io_unit_export>);
                    craftingTable.addShaped("assembly_io_unit_export_edit", <item:pneumaticcraft:assembly_io_unit_export>, [
                        [cylinder, cylinder, <item:create:brass_hand>],
                        [cylinder, air, air],
                        [<item:kubejs:compressed_iron_block>, <item:pneumaticcraft:printed_circuit_board>, <item:kubejs:compressed_iron_block>]]);
                #switching
                    craftingTable.addShapeless("import_to_export", <item:pneumaticcraft:assembly_io_unit_export>, [<item:pneumaticcraft:assembly_io_unit_import>]);
                    craftingTable.addShapeless("export_to_import", <item:pneumaticcraft:assembly_io_unit_import>, [<item:pneumaticcraft:assembly_io_unit_export>]);
            #controller
                craftingTable.removeRecipe(<item:pneumaticcraft:assembly_controller>);
                craftingTable.addShaped("assembly_controller_edit", <item:pneumaticcraft:assembly_controller>, [
                    [air, <item:pneumaticcraft:printed_circuit_board>, air],
                    [<item:pneumaticcraft:pressure_tube>, <item:pneumaticcraft:printed_circuit_board>, <item:pneumaticcraft:printed_circuit_board>],
                    [<item:kubejs:compressed_iron_block>, <item:kubejs:compressed_iron_block>, <item:kubejs:compressed_iron_block>]]);
        #pressure chamber
            #wall
                craftingTable.removeRecipe(<item:pneumaticcraft:pressure_chamber_wall>);
                craftingTable.addShaped("pressure_chamber_wall_edit", <item:pneumaticcraft:pressure_chamber_wall> * 4, [
                    [steelPlate, <item:pneumaticcraft:reinforced_stone>, steelPlate],
                    [<item:pneumaticcraft:reinforced_stone>, steelPlate, <item:pneumaticcraft:reinforced_stone>],
                    [steelPlate, <item:pneumaticcraft:reinforced_stone>, steelPlate]]);
            #glass
                craftingTable.removeRecipe(<item:pneumaticcraft:pressure_chamber_glass>);
                craftingTable.addShaped("pressure_chamber_glass_edit", <item:pneumaticcraft:pressure_chamber_glass> * 4, [
                    [<tag:items:forge:glass>, <item:pneumaticcraft:reinforced_stone>, <tag:items:forge:glass>],
                    [<item:pneumaticcraft:reinforced_stone>, <item:mekanism:block_refined_obsidian>, <item:pneumaticcraft:reinforced_stone>],
                    [<tag:items:forge:glass>, <item:pneumaticcraft:reinforced_stone>, <tag:items:forge:glass>]]);
                craftingTable.addShapeless("pressure_chamber_glass_conversion", <item:pneumaticcraft:pressure_chamber_glass>, [<tag:items:forge:glass>]);
            #valve
                craftingTable.removeRecipe(<item:pneumaticcraft:pressure_chamber_valve>);
                craftingTable.addShaped("pressure_chamber_valve_edit", <item:pneumaticcraft:pressure_chamber_valve>, [
                    [<item:pneumaticcraft:ingot_iron_compressed>, <item:kubejs:compressed_iron_block>, <item:pneumaticcraft:ingot_iron_compressed>],
                    [<item:kubejs:compressed_iron_block>, <item:pneumaticcraft:pressure_tube>, <item:kubejs:compressed_iron_block>],
                    [<item:pneumaticcraft:ingot_iron_compressed>, <item:kubejs:compressed_iron_block>, <item:pneumaticcraft:ingot_iron_compressed>]]);
            #interface
                craftingTable.removeRecipe(<item:pneumaticcraft:pressure_chamber_interface>);
                craftingTable.addShaped("pressure_chamber_interface_edit", <item:pneumaticcraft:pressure_chamber_interface>*2, [
                    [<item:immersiveengineering:conveyor_basic>, <item:pneumaticcraft:pressure_chamber_glass>, <item:pneumaticcraft:pressure_chamber_wall>],
                    [<item:pneumaticcraft:pressure_chamber_glass>, air, <item:pneumaticcraft:pressure_chamber_glass>],
                    [<item:pneumaticcraft:pressure_chamber_wall>, <item:pneumaticcraft:pressure_chamber_glass>, <item:immersiveengineering:conveyor_basic>]]);
        #tube
            craftingTable.removeRecipe(<item:pneumaticcraft:pressure_tube>);
            craftingTable.addShaped("pressure_tube", <item:pneumaticcraft:pressure_tube> * 8, [
                [<item:kubejs:compressed_iron_block>, <tag:items:forge:glass>, <item:kubejs:compressed_iron_block>]]);
        #compressors
            #air
                craftingTable.removeRecipe(<item:pneumaticcraft:air_compressor>);
                craftingTable.addShaped("air_compressor_edit", <item:pneumaticcraft:air_compressor>, [
                    [<item:pneumaticcraft:reinforced_bricks>, <item:pneumaticcraft:reinforced_bricks>, <item:pneumaticcraft:reinforced_bricks>],
                    [<item:pneumaticcraft:reinforced_bricks>, <tag:items:forge:storage_blocks/charcoal>, <item:pneumaticcraft:pressure_tube>],
                    [<item:pneumaticcraft:reinforced_bricks>, <item:minecraft:furnace>, <item:pneumaticcraft:reinforced_bricks>]]);
            #adv air
                craftingTable.removeRecipe(<item:pneumaticcraft:advanced_air_compressor>);
                craftingTable.addShaped("advanced_air_compressor_edit", <item:pneumaticcraft:advanced_air_compressor>, [
                    [<item:pneumaticcraft:ingot_iron_compressed>, <item:kubejs:compressed_iron_block>, <item:pneumaticcraft:ingot_iron_compressed>],
                    [<item:kubejs:compressed_iron_block>, <tag:items:forge:storage_blocks/charcoal>, <item:pneumaticcraft:advanced_pressure_tube>],
                    [<item:pneumaticcraft:ingot_iron_compressed>, <item:pneumaticcraft:air_compressor>, <item:pneumaticcraft:ingot_iron_compressed>]]);
            #adv liquid
                craftingTable.removeRecipe(<item:pneumaticcraft:advanced_liquid_compressor>);
                craftingTable.addShaped("advanced_liquid_compressor_edit", <item:pneumaticcraft:advanced_liquid_compressor>, [
                    [<item:pneumaticcraft:ingot_iron_compressed>, <item:kubejs:compressed_iron_block>, <item:pneumaticcraft:ingot_iron_compressed>],
                    [<item:kubejs:compressed_iron_block>, <item:pneumaticcraft:advanced_pressure_tube>, <item:pneumaticcraft:advanced_pressure_tube>],
                    [<item:pneumaticcraft:ingot_iron_compressed>, <item:pneumaticcraft:liquid_compressor>, <item:pneumaticcraft:ingot_iron_compressed>]]);
            #pneumatic
                craftingTable.removeRecipe(<item:pneumaticcraft:pneumatic_dynamo>);
                craftingTable.addShaped("pneumatic_dynamo_edit", <item:pneumaticcraft:pneumatic_dynamo>, [
                    [<item:pneumaticcraft:transistor>, <item:pneumaticcraft:advanced_pressure_tube>, <item:pneumaticcraft:capacitor>],
                    [<item:pneumaticcraft:compressed_iron_gear>, <item:kubejs:compressed_iron_block>, <item:pneumaticcraft:compressed_iron_gear>],
                    [<item:kubejs:compressed_iron_block>, <item:pneumaticcraft:printed_circuit_board>, <item:kubejs:compressed_iron_block>]]);
            #thermal
                craftingTable.removeRecipe(<item:pneumaticcraft:thermal_compressor>);
                craftingTable.addShaped("thermal_compressor_edit", <item:pneumaticcraft:thermal_compressor>, [
                    [<item:pneumaticcraft:pressure_tube>, <item:kubejs:compressed_iron_block>, <item:pneumaticcraft:pressure_tube>],
                    [<item:mekanism:superheating_element>, <item:pneumaticcraft:air_compressor>, <item:mekanism:superheating_element>],
                    [<item:pneumaticcraft:pressure_tube>, <item:kubejs:compressed_iron_block>, <item:pneumaticcraft:pressure_tube>]]);
        #reinforced stone
            craftingTable.removeRecipe(<item:pneumaticcraft:reinforced_stone>);
            craftingTable.addShaped("reinforced_stone_edit", <item:pneumaticcraft:reinforced_stone> * 4, [
                [air, <item:minecraft:stone>, air],
                [<item:minecraft:stone>, <item:kubejs:compressed_iron_block>, <item:minecraft:stone>],
                [air, <item:minecraft:stone>, air]]);
    #removals
        remove(<item:pneumaticcraft:jet_boots_upgrade_5>);
        remove(<item:pneumaticcraft:jet_boots_upgrade_4>);
        remove(<item:pneumaticcraft:jet_boots_upgrade_3>);
        remove(<item:pneumaticcraft:jet_boots_upgrade_2>);
        remove(<item:pneumaticcraft:jet_boots_upgrade_1>);
        remove(<item:pneumaticcraft:jumping_upgrade_4>);
        remove(<item:pneumaticcraft:jumping_upgrade_3>);
        remove(<item:pneumaticcraft:jumping_upgrade_2>);
        remove(<item:pneumaticcraft:jumping_upgrade_1>);
        remove(<item:pneumaticcraft:flippers_upgrade>);
        remove(<item:pneumaticcraft:scuba_upgrade>);
        remove(<item:pneumaticcraft:night_vision_upgrade>);
        remove(<item:pneumaticcraft:coordinate_tracker_upgrade>);
        remove(<item:pneumaticcraft:search_upgrade>);
        remove(<item:pneumaticcraft:pneumatic_helmet>);
        remove(<item:pneumaticcraft:pneumatic_chestplate>);
        remove(<item:pneumaticcraft:pneumatic_leggings>);
        remove(<item:pneumaticcraft:pneumatic_boots>);
        remove(<item:pneumaticcraft:reinforced_chest>);
        remove(<item:pneumaticcraft:smart_chest>);
#tinkers construct
    #items
        #seared bricks
            <recipetype:tconstruct:casting_basin>.removeRecipe(<item:tconstruct:seared_bricks>);
            stoneCutter.removeRecipe(<item:tconstruct:seared_bricks>);
            craftingTable.removeRecipe(<item:tconstruct:seared_bricks>);
            craftingTable.addShaped("seared_bricks_edit_stone", <item:tconstruct:seared_bricks> * 4, [
                [air, <item:tconstruct:seared_stone>, air],
                [<item:tconstruct:seared_stone>, ironPlate, <item:tconstruct:seared_stone>],
                [air, <item:tconstruct:seared_stone>, air]]);
            craftingTable.addShaped("seared_bricks_edit_bricks", <item:tconstruct:seared_bricks>, [
                [air, <item:tconstruct:seared_brick>, air],
                [<item:tconstruct:seared_brick>, ironPlate, <item:tconstruct:seared_brick>],
                [air, <item:tconstruct:seared_brick>, air]]);
        #pattern
            craftingTable.removeRecipe(<item:tconstruct:pattern>);
            craftingTable.addShaped("pattern_edit", <item:tconstruct:pattern> * 3, [
                [<tag:items:minecraft:planks>, <tag:items:forge:rods/wooden>, <tag:items:minecraft:planks>],
                [<tag:items:forge:rods/wooden>, <item:mekanism:cardboard_box>, <tag:items:forge:rods/wooden>],
                [<tag:items:minecraft:planks>, <tag:items:forge:rods/wooden>, <tag:items:minecraft:planks>]]);
        #iron reinforcement
            craftingTable.removeRecipe(<item:tconstruct:iron_reinforcement>);
            craftingTable.addShaped("iron_reinforcement_edit", <item:tconstruct:iron_reinforcement>, [
                [<item:minecraft:iron_block>, <item:kubejs:compressed_obsidian>, <item:minecraft:iron_block>],
                [<item:kubejs:compressed_obsidian>, <item:kubejs:chaotic_control_circuit>, <item:kubejs:compressed_obsidian>],
                [<item:minecraft:iron_block>, <item:kubejs:compressed_obsidian>, <item:minecraft:iron_block>]]);
    #molding
        #table
            #glowstone
                <recipetype:tconstruct:casting_table>.addItemCastingRecipe("glowstone_block_casting_table", <tag:items:tconstruct:casts/multi_use/nugget>, <fluid:thermal:glowstone> * 250, <item:minecraft:glowstone_dust>, 20, false, false);
            #chaotic
                <recipetype:tconstruct:casting_table>.addItemCastingRecipe("omega_ingot_casting_table", <tag:items:tconstruct:casts/multi_use/ingot>, <fluid:kubejs:omega_liquid> * 144, <item:kubejs:omega_ingot>, 144, false, false);
        #basin
            #glowstone
                <recipetype:tconstruct:casting_basin>.addItemCastingRecipe("glowstone_block_casting_basin", air, <fluid:thermal:glowstone> * 1000, <item:minecraft:glowstone>, 80, false, false);
            #chaotic
                <recipetype:tconstruct:casting_basin>.addItemCastingRecipe("omega_block_casting_basin", <item:minecraft:air>, <fluid:kubejs:omega_liquid> * 1296, <item:kubejs:omega_block>, 1000, false, false);
    #melting
        #energized glowstone
            <recipetype:tconstruct:melting>.addMeltingRecipe("glowstone_block_melting", <item:minecraft:glowstone>, <fluid:thermal:glowstone> * 1000, 500, 40);
            <recipetype:tconstruct:melting>.addMeltingRecipe("glowstone_dust_melting", <item:minecraft:glowstone_dust>, <fluid:thermal:glowstone> * 250, 500, 40);
        #redstone
            <recipetype:tconstruct:melting>.addMeltingRecipe("redstone_dust_melting", redstone, <fluid:thermal:redstone> * 100, 300, 20);
            <recipetype:tconstruct:melting>.addMeltingRecipe("redstone_block_melting", <item:minecraft:redstone_block>, <fluid:thermal:redstone> * 900, 300, 150);
        #terrasteel
            #base
                <recipetype:tconstruct:melting>.addMeltingRecipe("terrasteel_ingot_melting", <item:botania:terrasteel_ingot>, <fluid:kubejs:terrasteel_liquid> * 144, 800, 100);
                <recipetype:tconstruct:melting>.addMeltingRecipe("terrasteel_nugget_melting", <item:botania:terrasteel_nugget>, <fluid:kubejs:terrasteel_liquid> * 16, 800, 15);
                <recipetype:tconstruct:melting>.addMeltingRecipe("terrasteel_block_melting", <item:botania:terrasteel_block>, <fluid:kubejs:terrasteel_liquid> * 1296, 800, 750);
            #tools
                <recipetype:tconstruct:melting>.addMeltingRecipe("terrasteel_axe_melting", <item:botania:terra_axe>.anyDamage(), <fluid:kubejs:terrasteel_liquid> * 576, 800, 350);
                <recipetype:tconstruct:melting>.addMeltingRecipe("terrasteel_pick_melting", <item:botania:terra_pick>.anyDamage(), <fluid:kubejs:terrasteel_liquid> * 2592, 800, 1400);
                <recipetype:tconstruct:melting>.addMeltingRecipe("terrasteel_sword_melting", <item:botania:terra_sword>.anyDamage(), <fluid:kubejs:terrasteel_liquid> * 288, 800, 175);
                <recipetype:tconstruct:melting>.addMeltingRecipe("terrasteel_helmet_melting", <item:botania:terrasteel_helmet>.anyDamage(), <fluid:kubejs:terrasteel_liquid> * 432, 800, 260);
                <recipetype:tconstruct:melting>.addMeltingRecipe("terrasteel_chestplate_melting", <item:botania:terrasteel_chestplate>.anyDamage(), <fluid:kubejs:terrasteel_liquid> * 432, 800, 260);
                <recipetype:tconstruct:melting>.addMeltingRecipe("terrasteel_leggings_melting", <item:botania:terrasteel_leggings>.anyDamage(), <fluid:kubejs:terrasteel_liquid> * 432, 800, 260);
                <recipetype:tconstruct:melting>.addMeltingRecipe("terrasteel_boots_melting", <item:botania:terrasteel_boots>.anyDamage(), <fluid:kubejs:terrasteel_liquid> * 432, 800, 260);
        #omega
            <recipetype:tconstruct:melting>.addMeltingRecipe("omega_ingot_melting", <item:kubejs:omega_ingot>, <fluid:kubejs:omega_liquid> * 144, 1200, 144);
            <recipetype:tconstruct:melting>.addMeltingRecipe("omega_dust_melting", <item:kubejs:omega_dust>, <fluid:kubejs:omega_liquid> * 72, 1200, 72);
            <recipetype:tconstruct:melting>.addMeltingRecipe("omega_block_melting", <item:kubejs:omega_block>, <fluid:kubejs:omega_liquid> * 1296, 1200, 1200);
    #alloying
        #brass
            <recipetype:tconstruct:alloying>.removeRecipe(<fluid:tconstruct:molten_brass>);
            <recipetype:tconstruct:alloying>.addRecipe("brass_alloying_edit", [<fluid:tconstruct:molten_copper> * 1152, <fluid:tconstruct:molten_zinc> * 1152], <fluid:tconstruct:molten_brass> * 144, 1000);
        #chaotic
            <recipetype:tconstruct:alloying>.addRecipe("omega_liquid_alloy", [<fluid:tconstruct:molten_manyullyn> * 144, <fluid:kubejs:terrasteel_liquid> * 144, <fluid:tconstruct:molten_enderium> * 144], <fluid:kubejs:omega_liquid> * 144, 1200);
#inventory pets
    #removals
        remove(<item:inventorypets:pet_mickerson>);
        remove(<item:inventorypets:pet_flying_saddle>);
        remove(<item:inventorypets:pet_cheetah>);
        remove(<item:inventorypets:pet_enderman>);
        remove(<item:inventorypets:pet_house>);
        remove(<item:inventorypets:pet_nether_portal>);
        remove(<item:inventorypets:pet_grave>);
        remove(<item:inventorypets:pet_illuminati>);
        remove(<item:inventorypets:pet_cloud>);
        remove(<item:inventorypets:pet_wither>);
        remove(<item:inventorypets:pet_moon>);
        remove(<item:inventorypets:pet_juggernaut>);
        remove(<item:inventorypets:pet_blaze>);
        remove(<item:inventorypets:pet_brewing_stand>);
        remove(<item:inventorypets:pet_pacman>);
        remove(<item:inventorypets:pet_slime>);
#refined
    #removals
        remove(<item:refinedstorage:external_storage>);
    #items
        #grids
            #grid
                craftingTable.removeRecipe(<item:refinedstorage:wireless_grid>);
                craftingTable.addShaped("wireless_grid_edit", <item:refinedstorage:wireless_grid>, [
                    [<item:refinedstorage:quartz_enriched_iron>, <item:powah:ender_core>, <item:refinedstorage:quartz_enriched_iron>],
                    [<item:refinedstorage:quartz_enriched_iron>, <tag:items:refinedstorage:crafting_grid>, <item:refinedstorage:quartz_enriched_iron>],
                    [<item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:advanced_processor>, <item:refinedstorage:quartz_enriched_iron>]]);
            #crafting monitor
                #1
                    craftingTable.removeRecipe(<item:refinedstorage:wireless_crafting_monitor>);
                    craftingTable.addShaped("wireless_crafting_monitor_without_grid_edit", <item:refinedstorage:wireless_crafting_monitor>, [
                        [<item:refinedstorage:quartz_enriched_iron>, <item:powah:ender_core>, <item:refinedstorage:quartz_enriched_iron>],
                        [<item:refinedstorage:quartz_enriched_iron>, <tag:items:refinedstorage:crafting_monitor>, <item:refinedstorage:quartz_enriched_iron>],
                        [<item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:advanced_processor>, <item:refinedstorage:quartz_enriched_iron>]]);
                #2
                    craftingTable.addShaped("wireless_crafting_monitor_with_grid_edit", <item:refinedstorage:wireless_crafting_monitor>, [
                        [<item:refinedstorage:quartz_enriched_iron>, <item:powah:ender_core>, <item:refinedstorage:quartz_enriched_iron>],
                        [<item:refinedstorage:quartz_enriched_iron>, <tag:items:refinedstorage:crafting_monitor>, <item:refinedstorage:quartz_enriched_iron>],
                        [<item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:wireless_grid>, <item:refinedstorage:quartz_enriched_iron>]]);
            #fluid grid
                #1
                    craftingTable.removeRecipe(<item:refinedstorage:wireless_fluid_grid>);
                    craftingTable.addShaped("wireless_fluid_grid_without_grid_edit", <item:refinedstorage:wireless_fluid_grid>, [
                        [<item:refinedstorage:quartz_enriched_iron>, <item:powah:ender_core>, <item:refinedstorage:quartz_enriched_iron>],
                        [<item:refinedstorage:quartz_enriched_iron>, <tag:items:refinedstorage:fluid_grid>, <item:refinedstorage:quartz_enriched_iron>],
                        [<item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:advanced_processor>, <item:refinedstorage:quartz_enriched_iron>]]);
                #2
                    craftingTable.addShaped("wireless_fluid_grid_with_grid_edit", <item:refinedstorage:wireless_fluid_grid>, [
                        [<item:refinedstorage:quartz_enriched_iron>, <item:powah:ender_core>, <item:refinedstorage:quartz_enriched_iron>],
                        [<item:refinedstorage:quartz_enriched_iron>, <tag:items:refinedstorage:fluid_grid>, <item:refinedstorage:quartz_enriched_iron>],
                        [<item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:wireless_grid>, <item:refinedstorage:quartz_enriched_iron>]]);
            #crafting grid
                #1
                    craftingTable.removeRecipe(<item:refinedstorageaddons:wireless_crafting_grid>);
                    craftingTable.addShaped("wireless_crafting_grid_without_grid_edit", <item:refinedstorageaddons:wireless_crafting_grid>, [
                        [<item:refinedstorage:quartz_enriched_iron>, <item:powah:ender_core>, <item:refinedstorage:quartz_enriched_iron>],
                        [<item:refinedstorage:quartz_enriched_iron>, <tag:items:refinedstorage:crafting_grid>, <item:refinedstorage:quartz_enriched_iron>],
                        [<item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:advanced_processor>, <item:refinedstorage:quartz_enriched_iron>]]);
                #2
                    craftingTable.addShaped("wireless_crafting_grid_with_grid_edit", <item:refinedstorageaddons:wireless_crafting_grid>, [
                        [<item:refinedstorage:quartz_enriched_iron>, <item:powah:ender_core>, <item:refinedstorage:quartz_enriched_iron>],
                        [<item:refinedstorage:quartz_enriched_iron>, <tag:items:refinedstorage:crafting_grid>, <item:refinedstorage:quartz_enriched_iron>],
                        [<item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:wireless_grid>, <item:refinedstorage:quartz_enriched_iron>]]);
        #controller
            craftingTable.removeRecipe(<item:refinedstorage:controller>);
            craftingTable.addShaped("controller_refined_edit", <item:refinedstorage:controller>, [
                [<item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:advanced_processor>, <item:refinedstorage:quartz_enriched_iron>],
                [<item:refinedstorage:construction_core>, <item:refinedstorage:machine_casing>, <item:refinedstorage:destruction_core>],
                [<item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:advanced_processor>, <item:refinedstorage:quartz_enriched_iron>]]);
        #machine casing
            craftingTable.removeRecipe(<item:refinedstorage:machine_casing>);
            craftingTable.addShaped("machine_casing_edit", <item:refinedstorage:machine_casing>, [
                [<item:refinedstorage:quartz_enriched_iron>, steelPlate, <item:refinedstorage:quartz_enriched_iron>],
                [steelPlate, <item:kubejs:compressed_andesite>, steelPlate],
                [<item:refinedstorage:quartz_enriched_iron>, steelPlate, <item:refinedstorage:quartz_enriched_iron>]]);
        #crafting grid
            craftingTable.removeRecipe(<item:refinedstorage:crafting_grid>);
            craftingTable.addShaped("crafting_grid_edit", <item:refinedstorage:crafting_grid>, [
                [<item:minecraft:crafting_table>, <item:refinedstorage:advanced_processor>, <item:minecraft:crafting_table>],
                [<item:refinedstorage:advanced_processor>, <item:refinedstorage:grid>, <item:refinedstorage:advanced_processor>],
                [<item:minecraft:crafting_table>, ccc, <item:minecraft:crafting_table>]]);
        #quartz iron
            craftingTable.removeRecipe(<item:refinedstorage:quartz_enriched_iron>);
            craftingTable.addShaped("quartz_enriched_iron_edit", <item:refinedstorage:quartz_enriched_iron> * 4, [
                [ironPlate, <item:minecraft:quartz> | <tag:items:forge:dusts/quartz>, ironPlate],
                [<item:minecraft:quartz> | <tag:items:forge:dusts/quartz>, ironPlate, <item:minecraft:quartz> | <tag:items:forge:dusts/quartz>],
                [ironPlate, <item:minecraft:quartz> | <tag:items:forge:dusts/quartz>, ironPlate]]);
        #binding
            craftingTable.removeRecipe(<item:refinedstorage:processor_binding>);
            craftingTable.addShaped("processor_binding_edit", <item:refinedstorage:processor_binding> * 2, [
                [<item:minecraft:string>, <tag:items:forge:slimeballs>, <item:minecraft:string>]]);
        #processor
            #destruction
                craftingTable.removeRecipe(<item:refinedstorage:destruction_core>);
                craftingTable.addShapeless("destruction_core_edit", <item:refinedstorage:destruction_core>, [<item:draconicevolution:draconium_ingot>, <item:refinedstorage:improved_processor>]);
            #construction
                craftingTable.removeRecipe(<item:refinedstorage:construction_core>);
                craftingTable.addShapeless("construction_core_edit", <item:refinedstorage:construction_core>, [<item:rftoolsbase:dimensionalshard>, <item:refinedstorage:improved_processor>]);
            #raw
                #basic
                    craftingTable.removeRecipe(<item:refinedstorage:raw_basic_processor>);
                    craftingTable.addShaped("raw_basic_processor_edit", <item:refinedstorage:raw_basic_processor>, [
                        [<item:refinedstorage:processor_binding>, <item:minecraft:diamond>],
                        [<item:refinedstorage:silicon>, redstone]]);
                #improved
                    craftingTable.removeRecipe(<item:refinedstorage:raw_improved_processor>);
                    craftingTable.addShaped("raw_improved_processor_edit", <item:refinedstorage:raw_improved_processor>, [
                        [<item:refinedstorage:processor_binding>, <item:kubejs:omega_dust>],
                        [<item:refinedstorage:silicon>, redstone]]);
                #advanced
                    craftingTable.removeRecipe(<item:refinedstorage:raw_advanced_processor>);
                    craftingTable.addShaped("raw_advanced_processor_edit", <item:refinedstorage:raw_advanced_processor>, [
                        [<item:refinedstorage:processor_binding>, <item:kubejs:alloy_chaotic>],
                        [<item:refinedstorage:silicon>, redstone]]);
        #storage part
            #1k
                craftingTable.removeRecipe(<item:refinedstorage:1k_storage_part>);
                craftingTable.addShaped("1k_edit", <item:refinedstorage:1k_storage_part>, [
                    [<item:refinedstorage:silicon>, <item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:silicon>],
                    [<tag:items:forge:glass>, <item:thermal:enderium_ingot>, <tag:items:forge:glass>],
                    [<item:refinedstorage:silicon>, <tag:items:forge:glass>, <item:refinedstorage:silicon>]]);
            #4k
                craftingTable.removeRecipe(<item:refinedstorage:4k_storage_part>);
                craftingTable.addShaped("4k_edit", <item:refinedstorage:4k_storage_part>, [
                    [<item:refinedstorage:basic_processor>, <item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:basic_processor>],
                    [<item:refinedstorage:1k_storage_part>, <item:kubejs:omega_dust>, <item:refinedstorage:1k_storage_part>],
                    [<item:refinedstorage:basic_processor>, <item:refinedstorage:1k_storage_part>, <item:refinedstorage:basic_processor>]]);
            #16k
                craftingTable.removeRecipe(<item:refinedstorage:16k_storage_part>);
                craftingTable.addShaped("16k_edit", <item:refinedstorage:16k_storage_part>, [
                    [<item:refinedstorage:improved_processor>, <item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:improved_processor>],
                    [<item:refinedstorage:4k_storage_part>, <item:kubejs:alloy_chaotic>, <item:refinedstorage:4k_storage_part>],
                    [<item:refinedstorage:improved_processor>, <item:refinedstorage:4k_storage_part>, <item:refinedstorage:improved_processor>]]);
            #64k
                craftingTable.removeRecipe(<item:refinedstorage:64k_storage_part>);
                craftingTable.addShaped("64k_edit", <item:refinedstorage:64k_storage_part>, [
                    [<item:refinedstorage:advanced_processor>, <item:refinedstorage:quartz_enriched_iron>, <item:refinedstorage:advanced_processor>],
                    [<item:refinedstorage:16k_storage_part>, ccc, <item:refinedstorage:16k_storage_part>],
                    [<item:refinedstorage:advanced_processor>, <item:refinedstorage:16k_storage_part>, <item:refinedstorage:advanced_processor>]]);
            #fluid
                #to 64k
                    craftingTable.removeRecipe(<item:refinedstorage:64k_fluid_storage_part>);
                    craftingTable.addShapeless("rs_to_64k", <item:refinedstorage:64k_fluid_storage_part>, [<item:refinedstorage:1k_storage_part>, <item:minecraft:bucket>]);
                #from 64k
                    craftingTable.addShapeless("rs_from_64k", <item:refinedstorage:1k_storage_part>, [<item:refinedstorage:64k_fluid_storage_part>]);
                #to 256k
                    craftingTable.removeRecipe(<item:refinedstorage:256k_fluid_storage_part>);
                    craftingTable.addShapeless("rs_to_256k", <item:refinedstorage:256k_fluid_storage_part>, [<item:refinedstorage:4k_storage_part>, <item:minecraft:bucket>]);
                #from 256k
                    craftingTable.addShapeless("rs_from_256k", <item:refinedstorage:4k_storage_part>, [<item:refinedstorage:256k_fluid_storage_part>]);
                #to 1024k
                    craftingTable.removeRecipe(<item:refinedstorage:1024k_fluid_storage_part>);
                    craftingTable.addShapeless("rs_to_1024k", <item:refinedstorage:1024k_fluid_storage_part>, [<item:refinedstorage:16k_storage_part>, <item:minecraft:bucket>]);
                #from 1024k
                    craftingTable.addShapeless("rs_from_1024k", <item:refinedstorage:16k_storage_part>, [<item:refinedstorage:1024k_fluid_storage_part>]);
                #to 4096k
                    craftingTable.removeRecipe(<item:refinedstorage:4096k_fluid_storage_part>);
                    craftingTable.addShapeless("rs_to_4096k", <item:refinedstorage:4096k_fluid_storage_part>, [<item:refinedstorage:64k_storage_part>, <item:minecraft:bucket>]);
                #from 4096k
                    craftingTable.addShapeless("rs_from_4096k", <item:refinedstorage:64k_storage_part>, [<item:refinedstorage:4096k_fluid_storage_part>]);
#applied
    #inscriber
        #silicon
            <recipetype:appliedenergistics2:inscriber>.removeRecipe(<item:appliedenergistics2:printed_silicon>);
            <recipetype:appliedenergistics2:inscriber>.addInscribeRecipe("printed_silicon_edit", <item:appliedenergistics2:printed_silicon>, <tag:items:forge:silicon>, [<item:appliedenergistics2:silicon_press>, <item:minecraft:netherite_ingot>] as IIngredient[]);
        #logic
            <recipetype:appliedenergistics2:inscriber>.removeRecipe(<item:appliedenergistics2:logic_processor>);
            <recipetype:appliedenergistics2:inscriber>.addInscribeRecipe("logic_processor_edit", <item:appliedenergistics2:logic_processor>, <item:minecraft:diamond_block>, [<item:appliedenergistics2:printed_logic_processor>, <item:appliedenergistics2:printed_silicon>] as IIngredient[]);
        #calculation
            <recipetype:appliedenergistics2:inscriber>.removeRecipe(<item:appliedenergistics2:calculation_processor>);
            <recipetype:appliedenergistics2:inscriber>.addInscribeRecipe("calculation_processor_edit", <item:appliedenergistics2:calculation_processor>, <item:kubejs:omega_ingot>, [<item:appliedenergistics2:printed_calculation_processor>, <item:appliedenergistics2:printed_silicon>] as IIngredient[]);
        #engineering
            <recipetype:appliedenergistics2:inscriber>.removeRecipe(<item:appliedenergistics2:engineering_processor>);
            <recipetype:appliedenergistics2:inscriber>.addInscribeRecipe("engineering_processor_edit", <item:appliedenergistics2:engineering_processor>, <item:kubejs:alloy_chaotic> * 2, [<item:appliedenergistics2:printed_engineering_processor>, <item:appliedenergistics2:printed_silicon>] as IIngredient[]);
    #items
        #terminal
            craftingTable.removeRecipe(<item:appliedenergistics2:wireless_terminal>);
            craftingTable.addShaped("wireless_terminal_edit", <item:appliedenergistics2:wireless_terminal>, [
                [<item:appliedenergistics2:wireless_receiver>, <item:appliedenergistics2:engineering_processor>, ironPlate],
                [<item:appliedenergistics2:calculation_processor>, <item:appliedenergistics2:terminal>, <item:appliedenergistics2:calculation_processor>],
                [ironPlate, <item:appliedenergistics2:dense_energy_cell>, ironPlate]]);
        #storage component
            #items
                #1k
                    craftingTable.removeRecipe(<item:appliedenergistics2:1k_cell_component>);
                    craftingTable.addShaped("1k_cell_edit", <item:appliedenergistics2:1k_cell_component>, [
                        [<tag:items:appliedenergistics2:crystals/certus>, <item:appliedenergistics2:fluix_crystal>, <tag:items:appliedenergistics2:crystals/certus>],
                        [<tag:items:forge:glass>, <item:thermal:enderium_ingot>, <tag:items:forge:glass>],
                        [<tag:items:appliedenergistics2:crystals/certus>, <tag:items:forge:glass>, <tag:items:appliedenergistics2:crystals/certus>]]);
                #4k
                    craftingTable.removeRecipe(<item:appliedenergistics2:4k_cell_component>);
                    craftingTable.addShaped("4k_cell_edit", <item:appliedenergistics2:4k_cell_component>, [
                        [<tag:items:appliedenergistics2:crystals/certus>, <item:appliedenergistics2:logic_processor>, <tag:items:appliedenergistics2:crystals/certus>],
                        [<item:appliedenergistics2:1k_cell_component>, <item:kubejs:omega_dust>, <item:appliedenergistics2:1k_cell_component>],
                        [<tag:items:appliedenergistics2:crystals/certus>, <item:appliedenergistics2:1k_cell_component>, <tag:items:appliedenergistics2:crystals/certus>]]);
                #16k
                    craftingTable.removeRecipe(<item:appliedenergistics2:16k_cell_component>);
                    craftingTable.addShaped("16k_cell_edit", <item:appliedenergistics2:16k_cell_component>, [
                        [<tag:items:appliedenergistics2:crystals/certus>, <item:appliedenergistics2:calculation_processor>, <tag:items:appliedenergistics2:crystals/certus>],
                        [<item:appliedenergistics2:4k_cell_component>, <item:kubejs:alloy_chaotic>, <item:appliedenergistics2:4k_cell_component>],
                        [<tag:items:appliedenergistics2:crystals/certus>, <item:appliedenergistics2:4k_cell_component>, <tag:items:appliedenergistics2:crystals/certus>]]);
                #64k
                    craftingTable.removeRecipe(<item:appliedenergistics2:64k_cell_component>);
                    craftingTable.addShaped("64k_cell_edit", <item:appliedenergistics2:64k_cell_component>, [
                        [<tag:items:appliedenergistics2:crystals/certus>, <item:appliedenergistics2:engineering_processor>, <tag:items:appliedenergistics2:crystals/certus>],
                        [<item:appliedenergistics2:16k_cell_component>, ccc, <item:appliedenergistics2:16k_cell_component>],
                        [<tag:items:appliedenergistics2:crystals/certus>, <item:appliedenergistics2:16k_cell_component>, <tag:items:appliedenergistics2:crystals/certus>]]);
            #fluid
                #to 1k
                    craftingTable.removeRecipe(<item:appliedenergistics2:1k_fluid_cell_component>);
                    craftingTable.addShapeless("ae2_to_1k", <item:appliedenergistics2:1k_fluid_cell_component>, [<item:appliedenergistics2:1k_cell_component>, <item:minecraft:bucket>]);
                #from 1k
                    craftingTable.addShapeless("ae2_from_1k", <item:appliedenergistics2:1k_cell_component>, [<item:appliedenergistics2:1k_fluid_cell_component>]);
                #to 4k
                    craftingTable.removeRecipe(<item:appliedenergistics2:4k_fluid_cell_component>);
                    craftingTable.addShapeless("ae2_to_4k", <item:appliedenergistics2:4k_fluid_cell_component>, [<item:appliedenergistics2:4k_cell_component>, <item:minecraft:bucket>]);
                #from 4k
                    craftingTable.addShapeless("ae2_from_4k", <item:appliedenergistics2:4k_cell_component>, [<item:appliedenergistics2:4k_fluid_cell_component>]);
                #to 16k
                    craftingTable.removeRecipe(<item:appliedenergistics2:16k_fluid_cell_component>);
                    craftingTable.addShapeless("ae2_to_16k", <item:appliedenergistics2:16k_fluid_cell_component>, [<item:appliedenergistics2:16k_cell_component>, <item:minecraft:bucket>]);
                #from 16k
                    craftingTable.addShapeless("ae2_from_16k", <item:appliedenergistics2:16k_cell_component>, [<item:appliedenergistics2:16k_fluid_cell_component>]);
                #to 64k
                    craftingTable.removeRecipe(<item:appliedenergistics2:64k_fluid_cell_component>);
                    craftingTable.addShapeless("ae2_to_64k", <item:appliedenergistics2:64k_fluid_cell_component>, [<item:appliedenergistics2:64k_cell_component>, <item:minecraft:bucket>]);
                #from 64k
                    craftingTable.addShapeless("ae2_from_64k", <item:appliedenergistics2:64k_cell_component>, [<item:appliedenergistics2:64k_fluid_cell_component>]);
    #removals
        remove(<item:appliedenergistics2:sky_stone_chest>);
        remove(<item:appliedenergistics2:smooth_sky_stone_chest>);
        remove(<item:ae2wtlib:infinity_booster_card>);
#ender storage
    #items
        #tank
            craftingTable.removeRecipe(<item:enderstorage:ender_tank>);
            craftingTable.addShaped("ender_tank_link_edit", <item:enderstorage:ender_tank>, [
                [<item:minecraft:blaze_rod>, <item:minecraft:white_wool>, <item:minecraft:blaze_rod>],
                [<item:kubejs:compressed_obsidian>, <item:mekanism:elite_fluid_tank>, <item:kubejs:compressed_obsidian>],
                [<item:minecraft:blaze_rod>, <item:mekanism:teleportation_core>, <item:minecraft:blaze_rod>]]);
        #pouch
            craftingTable.removeRecipe(<item:enderstorage:ender_pouch>);
            craftingTable.addShaped("ender_pouch_link_edit", <item:enderstorage:ender_pouch>, [
                [<item:minecraft:blaze_rod>, <item:minecraft:white_wool>, <item:minecraft:blaze_rod>],
                [<item:kubejs:compressed_obsidian>, <item:simplybackpacks:uncommonbackpack>, <item:kubejs:compressed_obsidian>],
                [<item:minecraft:blaze_rod>, <item:mekanism:teleportation_core>, <item:minecraft:blaze_rod>]]);
        #chest
            craftingTable.removeRecipe(<item:enderstorage:ender_chest>);
            craftingTable.addShaped("ender_chest_link_edit", <item:enderstorage:ender_chest>, [
                [<item:minecraft:blaze_rod>, <item:minecraft:white_wool>, <item:minecraft:blaze_rod>],
                [<item:kubejs:compressed_obsidian>, <tag:items:forge:chests>, <item:kubejs:compressed_obsidian>],
                [<item:minecraft:blaze_rod>, <item:mekanism:teleportation_core>, <item:minecraft:blaze_rod>]]);
#draconic
    #attributes
        #sword
            <item:draconicevolution:wyvern_sword>.addGlobalAttributeModifier(<attribute:minecraft:generic.attack_damage>, "Wyvern Sword Power", -0.2, AttributeOperation.MULTIPLY_BASE, [<equipmentslottype:mainhand>]);
            <item:draconicevolution:draconic_sword>.addGlobalAttributeModifier(<attribute:minecraft:generic.attack_damage>, "Draconic Sword Power", -0.3, AttributeOperation.MULTIPLY_BASE, [<equipmentslottype:mainhand>]);
            <item:draconicevolution:chaotic_sword>.addGlobalAttributeModifier(<attribute:minecraft:generic.attack_damage>, "Chaotic Sword Power", -0.4, AttributeOperation.MULTIPLY_BASE, [<equipmentslottype:mainhand>]);
        #axe
            <item:draconicevolution:wyvern_axe>.addGlobalAttributeModifier(<attribute:minecraft:generic.attack_damage>, "Wyvern Axe Power", -0.3, AttributeOperation.MULTIPLY_BASE, [<equipmentslottype:mainhand>]);
            <item:draconicevolution:draconic_axe>.addGlobalAttributeModifier(<attribute:minecraft:generic.attack_damage>, "Draconic Axe Power", -0.45, AttributeOperation.MULTIPLY_BASE, [<equipmentslottype:mainhand>]);
            <item:draconicevolution:chaotic_axe>.addGlobalAttributeModifier(<attribute:minecraft:generic.attack_damage>, "Chaotic Axe Power", -0.6, AttributeOperation.MULTIPLY_BASE, [<equipmentslottype:mainhand>]);
        #pickaxe
            <item:draconicevolution:wyvern_pickaxe>.addGlobalAttributeModifier(<attribute:minecraft:generic.attack_damage>, "Wyvern Pickaxe Power", -0.2, AttributeOperation.MULTIPLY_BASE, [<equipmentslottype:mainhand>]);
            <item:draconicevolution:draconic_pickaxe>.addGlobalAttributeModifier(<attribute:minecraft:generic.attack_damage>, "Draconic Pickaxe Power", -0.3, AttributeOperation.MULTIPLY_BASE, [<equipmentslottype:mainhand>]);
            <item:draconicevolution:chaotic_pickaxe>.addGlobalAttributeModifier(<attribute:minecraft:generic.attack_damage>, "Chaotic Pickaxe Power", -0.4, AttributeOperation.MULTIPLY_BASE, [<equipmentslottype:mainhand>]);
        #shovel
            <item:draconicevolution:wyvern_shovel>.addGlobalAttributeModifier(<attribute:minecraft:generic.attack_damage>, "Wyvern Shovel Power", -0.2, AttributeOperation.MULTIPLY_BASE, [<equipmentslottype:mainhand>]);
            <item:draconicevolution:draconic_shovel>.addGlobalAttributeModifier(<attribute:minecraft:generic.attack_damage>, "Draconic Shovel Power", -0.3, AttributeOperation.MULTIPLY_BASE, [<equipmentslottype:mainhand>]);
            <item:draconicevolution:chaotic_shovel>.addGlobalAttributeModifier(<attribute:minecraft:generic.attack_damage>, "Chaotic Shovel Power", -0.4, AttributeOperation.MULTIPLY_BASE, [<equipmentslottype:mainhand>]);
        #staff
            <item:draconicevolution:draconic_staff>.addGlobalAttributeModifier(<attribute:minecraft:generic.attack_damage>, "Draconic Staff Power", -0.35, AttributeOperation.MULTIPLY_BASE, [<equipmentslottype:mainhand>]);
            <item:draconicevolution:chaotic_staff>.addGlobalAttributeModifier(<attribute:minecraft:generic.attack_damage>, "Chaotic Staff Power", -0.45, AttributeOperation.MULTIPLY_BASE, [<equipmentslottype:mainhand>]);
    #jei
        #draconium
            mods.jei.JEI.addInfo(<item:draconicevolution:overworld_draconium_ore>, ["Compressed by the depths and energy from deep lava pools. Draconium ore is most commonly found in overworld basalt."]);
            mods.jei.JEI.addInfo(<item:draconicevolution:draconium_ingot>, ["Compressed by the depths and energy from deep lava pools. Draconium ore is most commonly found in overworld basalt."]);
            mods.jei.JEI.addInfo(<item:draconicevolution:draconium_dust>, ["Compressed by the depths and energy from deep lava pools. Draconium ore is most commonly found in overworld basalt."]);
    #fusion
        #chaotic fusion crafting injection
            <recipetype:draconicevolution:fusion_crafting>.removeRecipe(<item:draconicevolution:chaotic_crafting_injector>);
            <recipetype:draconicevolution:fusion_crafting>.addRecipe("chaotic_crafting_injector_fusion_edit", <item:draconicevolution:chaotic_crafting_injector>, <item:draconicevolution:awakened_crafting_injector>, 20000000, TechLevel.DRACONIC, [<item:minecraft:diamond>, <item:minecraft:diamond>, <item:draconicevolution:large_chaos_frag>, <item:draconicevolution:large_chaos_frag>, <item:draconicevolution:large_chaos_frag>, <item:draconicevolution:large_chaos_frag>, <item:draconicevolution:awakened_core>, <item:minecraft:diamond>, <item:minecraft:diamond>]);
        #draconic chest
            <recipetype:draconicevolution:fusion_crafting>.removeRecipe(<item:draconicevolution:draconium_chest>);
            <recipetype:draconicevolution:fusion_crafting>.addRecipe("draconium_chest_fusion_edit", <item:draconicevolution:draconium_chest>, <item:minecraft:chest>, 200000, TechLevel.WYVERN, [<item:minecraft:furnace>, <item:draconicevolution:wyvern_core>, <item:minecraft:furnace>, <item:minecraft:crafting_table>, <item:minecraft:furnace>, <item:kubejs:alloy_chaotic>, <item:minecraft:furnace>, <item:minecraft:crafting_table>, <item:minecraft:furnace>, <item:draconicevolution:wyvern_core>]);
        #reactor
            <recipetype:draconicevolution:fusion_crafting>.removeRecipe(<item:draconicevolution:reactor_core>);
            <recipetype:draconicevolution:fusion_crafting>.addRecipe("reactor_core_fusion_edit", <item:draconicevolution:reactor_core>, <item:kubejs:reactor_core>, 10000000000, TechLevel.CHAOTIC, [<item:draconicevolution:awakened_draconium_block>, <item:botania:terrasteel_block>, <item:draconicevolution:awakened_draconium_block>, <item:create:brass_block>, <item:draconicevolution:awakened_draconium_block>, <item:pneumaticcraft:compressed_iron_block>, <item:draconicevolution:awakened_draconium_block>, ech, ech]);
        #flux block
            <recipetype:draconicevolution:fusion_crafting>.addRecipe("flux_block_fusion", <item:fluxnetworks:flux_block>, <item:minecraft:redstone_block>, 100000, TechLevel.WYVERN, [<item:fluxnetworks:flux_core>, <item:fluxnetworks:flux_core>, <item:fluxnetworks:flux_core>, <item:fluxnetworks:flux_core>, <item:fluxnetworks:flux_core>, <item:fluxnetworks:flux_core>, <item:fluxnetworks:flux_core>, <item:fluxnetworks:flux_core>]);
    #items
        #module core
            craftingTable.removeRecipe(<item:draconicevolution:module_core>);
            craftingTable.addShaped("module_core_edit", <item:draconicevolution:module_core>, [
                [ironPlate, redstone, ironPlate],
                [goldPlate, <item:draconicevolution:draconium_core>, goldPlate],
                [ironPlate, redstone, ironPlate]]);
        #item dislocator
            craftingTable.removeRecipe(<item:draconicevolution:magnet>);
            craftingTable.addShaped("item_diclocator_edit", <item:draconicevolution:magnet>, [
                [redstone, air, redstone],
                [<item:draconicevolution:draconium_ingot>, air, <item:draconicevolution:draconium_ingot>],
                [<item:draconicevolution:draconium_core>, <item:draconicevolution:wyvern_core>, <item:draconicevolution:draconium_core>]]);
        #info tablet
            craftingTable.addShapeless("info_tablet", <item:draconicevolution:info_tablet>, [<tag:items:forge:stone>, redstone]);
        #dragon heart
            craftingTable.addShaped("dragon_heart", <item:draconicevolution:dragon_heart>, [
                [<item:thermal:signalum_block>, <item:thermal:signalum_block>, <item:thermal:signalum_block>],
                [<item:thermal:signalum_block>, <item:quark:diamond_heart>, <item:thermal:signalum_block>],
                [<item:thermal:signalum_block>, <item:thermal:signalum_block>, <item:thermal:signalum_block>]]);
        #small chaos
            craftingTable.addShapeless("small_chaos_frag_edit", <item:draconicevolution:medium_chaos_frag>, [ccc]);
    #removals
        remove(<item:draconicevolution:chaotic_speed_module>);
        remove(<item:draconicevolution:chaotic_damage_module>);
        remove(<item:draconicevolution:chaotic_proj_damage_module>);
        remove(<item:draconicevolution:chaotic_shield_control_module>);
        remove(<item:draconicevolution:chaotic_shield_capacity_module>);
        remove(<item:draconicevolution:chaotic_shield_recovery_module>);
        remove(<item:draconicevolution:chaotic_jump_module>);
        remove(<item:draconicevolution:chaotic_flight_module>);
        remove(<item:draconicevolution:chaotic_large_shield_capacity_module>);
        remove(<item:draconicevolution:draconic_speed_module>);
        remove(<item:draconicevolution:draconic_damage_module>);
        remove(<item:draconicevolution:draconic_proj_damage_module>);
        remove(<item:draconicevolution:draconic_jump_module>);
        remove(<item:draconicevolution:draconic_shield_control_module>);
        remove(<item:draconicevolution:wyvern_shield_control_module>);
        remove(<item:draconicevolution:draconic_large_shield_capacity_module>);
        remove(<item:draconicevolution:draconic_shield_capacity_module>);
        remove(<item:draconicevolution:wyvern_large_shield_capacity_module>);
        remove(<item:draconicevolution:wyvern_shield_capacity_module>);
        remove(<item:draconicevolution:draconic_shield_recovery_module>);
        remove(<item:draconicevolution:wyvern_shield_recovery_module>);
        remove(<item:draconicevolution:wyvern_undying_module>);
        remove(<item:draconicevolution:draconic_undying_module>);
        remove(<item:draconicevolution:chaotic_undying_module>);
        remove(<item:draconicevolution:wyvern_flight_module>);
        remove(<item:draconicevolution:draconic_flight_module>);
        remove(<item:draconicevolution:dislocator>);
        remove(<item:draconicevolution:advanced_dislocator>);
        remove(<item:draconicevolution:p2p_dislocator_unbound>);
        remove(<item:draconicevolution:player_dislocator_unbound>);
        remove(<item:draconicevolution:wyvern_damage_module>);
        remove(<item:draconicevolution:draconium_damage_module>);
/*
To do
    
*/