#priority 5
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
        }
    }
#other functions
    #drawers
        function drawerVariations(wood_type as string) as int {
                craftingTable.removeRecipe(<item:storagedrawers:${wood_type}_full_drawers_1>);
                craftingTable.addShaped(wood_type + "_full_drawer_edit", <item:storagedrawers:${wood_type}_full_drawers_1>, [
                    [<item:minecraft:${wood_type}_planks>, <item:minecraft:${wood_type}_planks>, <item:minecraft:${wood_type}_planks>],
                    [<item:minecraft:air>, <tag:items:forge:chests>, <item:minecraft:air>],
                    [<item:minecraft:${wood_type}_planks>, <item:minecraft:${wood_type}_planks>, <item:minecraft:${wood_type}_planks>]]);
                craftingTable.removeRecipe(<item:storagedrawers:${wood_type}_full_drawers_2>);
                craftingTable.addShaped(wood_type + "_double_drawer_edit", <item:storagedrawers:${wood_type}_full_drawers_2> * 2, [
                    [<item:minecraft:${wood_type}_planks>, <tag:items:forge:chests>, <item:minecraft:${wood_type}_planks>],
                    [<item:minecraft:${wood_type}_planks>, <item:minecraft:${wood_type}_planks>, <item:minecraft:${wood_type}_planks>],
                    [<item:minecraft:${wood_type}_planks>, <tag:items:forge:chests>, <item:minecraft:${wood_type}_planks>]]);
                craftingTable.removeRecipe(<item:storagedrawers:${wood_type}_full_drawers_4>);
                craftingTable.addShaped(wood_type + "_quad_drawer_edit", <item:storagedrawers:${wood_type}_full_drawers_4> * 4, [
                    [<tag:items:forge:chests>, <item:minecraft:${wood_type}_planks>, <tag:items:forge:chests>],
                    [<item:minecraft:${wood_type}_planks>, <item:minecraft:${wood_type}_planks>, <item:minecraft:${wood_type}_planks>],
                    [<tag:items:forge:chests>, <item:minecraft:${wood_type}_planks>, <tag:items:forge:chests>]]);
                craftingTable.removeRecipe(<item:storagedrawers:${wood_type}_half_drawers_1>);
                craftingTable.addShaped(wood_type + "_full_small_drawer_edit", <item:storagedrawers:${wood_type}_half_drawers_1>, [
                    [<item:minecraft:${wood_type}_slab>, <item:minecraft:${wood_type}_slab>, <item:minecraft:${wood_type}_slab>],
                    [<item:minecraft:air>, <tag:items:forge:chests>, <item:minecraft:air>],
                    [<item:minecraft:${wood_type}_slab>, <item:minecraft:${wood_type}_slab>, <item:minecraft:${wood_type}_slab>]]);
                craftingTable.removeRecipe(<item:storagedrawers:${wood_type}_half_drawers_2>);
                craftingTable.addShaped(wood_type + "_double_small_drawer_edit", <item:storagedrawers:${wood_type}_half_drawers_2> * 2, [
                    [<item:minecraft:${wood_type}_slab>, <tag:items:forge:chests>, <item:minecraft:${wood_type}_slab>],
                    [<item:minecraft:${wood_type}_slab>, <item:minecraft:${wood_type}_slab>, <item:minecraft:${wood_type}_slab>],
                    [<item:minecraft:${wood_type}_slab>, <tag:items:forge:chests>, <item:minecraft:${wood_type}_slab>]]);
                craftingTable.removeRecipe(<item:storagedrawers:${wood_type}_half_drawers_4>);
                craftingTable.addShaped(wood_type + "_quad_small_drawer_edit", <item:storagedrawers:${wood_type}_half_drawers_4> * 4, [
                    [<tag:items:forge:chests>, <item:minecraft:${wood_type}_slab>, <tag:items:forge:chests>],
                    [<item:minecraft:${wood_type}_slab>, <item:minecraft:${wood_type}_slab>, <item:minecraft:${wood_type}_slab>],
                    [<tag:items:forge:chests>, <item:minecraft:${wood_type}_slab>, <tag:items:forge:chests>]]);
                craftingTable.addShaped(wood_type + "_trim_edit", <item:storagedrawers:${wood_type}_half_drawers_4> * 4, [
                    [<item:minecraft:${wood_type}_planks>, <item:minecraft:stick>, <item:minecraft:${wood_type}_planks>],
                    [<item:minecraft:stick>, <item:minecraft:${wood_type}_planks>, <item:minecraft:stick>],
                    [<item:minecraft:${wood_type}_planks>, <item:minecraft:stick>, <item:minecraft:${wood_type}_planks>]]);
            }
//remove(<item:>);
#kubejs
    #items
        #empty heart token
            craftingTable.addShaped("empty_heart_token", <item:kubejs:empty_heart_token>, [
                [air, <item:forbidden_arcanus:arcane_crystal>, air],
                [<item:forbidden_arcanus:arcane_crystal>, <item:lifesteal:heart_core>, <item:forbidden_arcanus:arcane_crystal>],
                [air, <item:forbidden_arcanus:arcane_crystal>, air]]);
        #reactor core
            craftingTable.addShaped("reactor_core", <item:kubejs:reactor_core>, [
                [<item:mekanism:ultimate_induction_cell>, <item:mekanism:block_refined_obsidian>, <item:mekanism:ultimate_induction_cell>],
                [<item:mekanism:block_refined_obsidian>, ccc, <item:mekanism:block_refined_obsidian>],
                [<item:mekanism:ultimate_induction_cell>, <item:mekanism:block_refined_obsidian>, <item:mekanism:ultimate_induction_cell>]]);
        #chaotic conversions
            #block
                craftingTable.addShapeless("omega_ingot_to_block", <item:kubejs:omega_block>, [
                    <item:kubejs:omega_ingot>, <item:kubejs:omega_ingot>, <item:kubejs:omega_ingot>, <item:kubejs:omega_ingot>, <item:kubejs:omega_ingot>, <item:kubejs:omega_ingot>, <item:kubejs:omega_ingot>, <item:kubejs:omega_ingot>, <item:kubejs:omega_ingot>]);
            #ingot
                craftingTable.addShapeless("omega_block_to_ingot", <item:kubejs:omega_ingot> * 9, [<item:kubejs:omega_block>]);
#computercraft
    #items
        #pocket adv
            craftingTable.removeRecipe(<item:computercraft:pocket_computer_advanced>);
            craftingTable.addShaped("pocket_computer_advanced_edit", <item:computercraft:pocket_computer_advanced>, [
                [goldPlate, goldPlate, goldPlate],
                [<item:minecraft:gold_block>, <item:computercraft:pocket_computer_normal>, <item:minecraft:gold_block>],
                [goldPlate, <tag:items:forge:glass_panes>, goldPlate]]);
        #computer adv
            craftingTable.removeRecipe(<item:computercraft:computer_advanced>);
            craftingTable.addShaped("computer_advanced_edit", <item:computercraft:computer_advanced>, [
                [goldPlate, goldPlate, goldPlate],
                [goldPlate, <item:computercraft:computer_normal>, goldPlate],
                [goldPlate, <item:rftoolscontrol:cpu_core_1000>, goldPlate]]);
        #turtle adv 1
            craftingTable.removeRecipe(<item:computercraft:turtle_advanced>);
            craftingTable.addShaped("turtle_advanced_edit_1", <item:computercraft:turtle_advanced>, [
                [brassPlate, brassPlate, brassPlate],
                [brassPlate, <item:computercraft:computer_advanced>, brassPlate],
                [brassPlate, <item:rftoolscontrol:cpu_core_2000>, brassPlate]]);
        #turtle adv 2
            craftingTable.addShaped("turtle_advanced_edit_2", <item:computercraft:turtle_advanced>, [
                [brassPlate, <item:minecraft:gold_block>, brassPlate],
                [brassPlate, <item:computercraft:turtle_normal>, brassPlate],
                [brassPlate, <item:rftoolscontrol:cpu_core_2000>, brassPlate]]);
        #turtle
            craftingTable.removeRecipe(<item:computercraft:turtle_normal>);
            craftingTable.addShaped("turtle_edit", <item:computercraft:turtle_normal>, [
                [ironPlate, ironPlate, ironPlate],
                [ironPlate, <item:computercraft:computer_normal>, ironPlate],
                [ironPlate, <item:rftoolscontrol:cpu_core_1000>, ironPlate]]);
        #computer
            craftingTable.removeRecipe(<item:computercraft:computer_normal>);
            craftingTable.addShaped("computer_edit", <item:computercraft:computer_normal>, [
                [uraniumPlate, leadPlate, steelPlate],
                [invarPlate, <item:rftoolscontrol:cpu_core_500>, <tag:items:forge:glass_panes>],
                [tinPlate, ironPlate, aluminumPlate]]);
#lifesteal
    #removals
        craftingTable.removeRecipe(<item:lifesteal:heart_core>);
        remove(<item:lifesteal:heart_crystal>);
#eidolon
    #removals
        remove(<item:eidolon:prestigious_palm>);
    #items
        #pickaxe of inversion
            Worktable.remove("eidolon:reversal_pick");
            Worktable.register("reversal_pick_edit",
                [<item:kubejs:compressed_obsidian>, <item:mekanism:block_refined_obsidian>, <item:kubejs:compressed_obsidian>,
                air, <item:eidolon:pewter_block>, air,
                air, <item:moremekanismprocessing:tungsten_ingot>, air], 
                [<item:cyclic:ender_eye_reuse>, <item:eidolon:lesser_soul_gem>, <item:kubejs:alloy_chaotic>, <item:eidolon:lesser_soul_gem>], 
                <item:eidolon:reversal_pick>,
                (usualOut, core, extra) => {
                    return usualOut;
                });
        #basic amulet
            craftingTable.removeRecipe(<item:eidolon:basic_amulet>);
            craftingTable.addShaped("basic_amulet_edit", <item:eidolon:basic_amulet>, [
                [air, <item:botania:manaweave_cloth>, air],
                [<item:botania:manaweave_cloth>, air, <item:botania:manaweave_cloth>],
                [air, <item:eidolon:arcane_gold_block>, air]]);
        #magic workbench
            craftingTable.removeRecipe(<item:eidolon:worktable>);
            craftingTable.addShaped("worktable_edit", <item:eidolon:worktable>, [
                [<tag:items:minecraft:wooden_slabs>, <item:minecraft:red_carpet>, <tag:items:minecraft:wooden_slabs>],
                [<item:eidolon:pewter_block>, <item:lifesteal:heart_core>, <item:eidolon:pewter_block>],
                [<tag:items:minecraft:planks>, <tag:items:minecraft:planks>, <tag:items:minecraft:planks>]]);
        #soul enchanter
            Worktable.remove("eidolon:soul_enchanter");
            Worktable.register("soul_enchanter_worktable",
                [air, <item:minecraft:book>, air,
                <item:eidolon:arcane_gold_ingot>, <item:minecraft:obsidian>, <item:eidolon:arcane_gold_ingot>,
                <item:minecraft:obsidian>, <item:minecraft:obsidian>, <item:minecraft:obsidian>], 
                [<item:lifesteal:heart_core>, <item:eidolon:gold_inlay>, steelPlate, <item:eidolon:gold_inlay>], 
                <item:eidolon:soul_enchanter>,
                (usualOut, core, extra) => {
                    return usualOut;
                });
        #pewter blend
            craftingTable.removeRecipe(<item:eidolon:pewter_blend>);
            craftingTable.addShapeless("pewter_blend_edit", <item:eidolon:pewter_blend>, [<tag:items:forge:ingots/steel>, <tag:items:forge:ingots/lead>, <item:minecraft:blaze_powder>]);
#apotheosis
    #items
        #enchantment library
            Replacer.forMods("apotheosis").replace(<item:minecraft:enchanting_table>, csh).execute();
        #altar of the sea
            craftingTable.removeRecipe(<item:apotheosis:prismatic_altar>);
            craftingTable.addShaped("prismatic_altar_edit", <item:apotheosis:prismatic_altar>, [
                [<item:minecraft:mossy_stone_bricks>, air, <item:minecraft:mossy_stone_bricks>],
                [<item:minecraft:mossy_stone_bricks>, <item:minecraft:sea_lantern>, <item:minecraft:mossy_stone_bricks>],
                [<item:minecraft:mossy_stone_bricks>, <item:minecraft:enchanting_table>, <item:minecraft:mossy_stone_bricks>]]);
    #removals
        mods.jei.JEI.hideItem(<item:minecraft:potion>.withTag({Potion:"apotheosis:absorption" as string}));
        mods.jei.JEI.hideItem(<item:minecraft:potion>.withTag({Potion:"apotheosis:strong_absorption" as string}));
        mods.jei.JEI.hideItem(<item:minecraft:potion>.withTag({Potion:"apotheosis:long_absorption" as string}));
        brewing.removeRecipeByOutputPotion(<potion:apotheosis:absorption>);
        brewing.removeRecipeByOutputPotion(<potion:apotheosis:strong_absorption>);
        brewing.removeRecipeByOutputPotion(<potion:apotheosis:long_absorption>);
        remove(<item:apotheosis:potion_charm>.withTag({Potion: "apotheosis:absorption" as string}));
        remove(<item:apotheosis:potion_charm>.withTag({Potion: "apotheosis:long_absorption" as string}));
        remove(<item:apotheosis:potion_charm>.withTag({Potion: "apotheosis:strong_absorption" as string}));
#potion master
    #items
        #pestle
            craftingTable.removeRecipe(<item:potionsmaster:pestle>);
            craftingTable.addShaped("pestle_edit", <item:potionsmaster:pestle>, [
                [<item:minecraft:black_dye>, <item:minecraft:quartz>, <item:minecraft:black_dye>],
                [<item:minecraft:black_dye>, <item:minecraft:quartz>, <item:minecraft:black_dye>],
                [<item:minecraft:black_dye>, <item:botania:mana_diamond>, <item:minecraft:black_dye>]]);
        #mortar
            craftingTable.removeRecipe(<item:potionsmaster:tile_mortar>);
            craftingTable.addShaped("tile_mortar_edit", <item:potionsmaster:tile_mortar>, [
                [air, air, air],
                [ironPlate, <item:minecraft:cauldron>, ironPlate],
                [steelPlate, ironPlate, steelPlate]]);
    #removals
        remove(<item:potionsmaster:allthemodium_powder>);
        remove(<item:potionsmaster:vibranium_powder>);
        remove(<item:potionsmaster:unobtainium_powder>);
        remove(<item:potionsmaster:platinum_powder>);
        remove(<item:potionsmaster:crimsoniron_powder>);
        remove(<item:potionsmaster:bismuth_powder>);
        remove(<item:potionsmaster:calcinatedallthemodium_powder>);
        remove(<item:potionsmaster:calcinatedvibranium_powder>);
        remove(<item:potionsmaster:calcinatedunobtainium_powder>);
        remove(<item:potionsmaster:calcinatedplatinum_powder>);
        remove(<item:potionsmaster:calcinatedcrimsoniron_powder>);
        remove(<item:potionsmaster:calcinatedbismuth_powder>);
        removePotion(<item:minecraft:splash_potion>.withTag({Potion: "potionsmaster:bismuth_sight" as string}), <potion:potionsmaster:bismuth_sight>); 
        removePotion(<item:minecraft:splash_potion>.withTag({Potion: "potionsmaster:vibranium_sight" as string}), <potion:potionsmaster:vibranium_sight>);
        removePotion(<item:minecraft:splash_potion>.withTag({Potion: "potionsmaster:unobtainium_sight" as string}), <potion:potionsmaster:unobtainium_sight>);
        removePotion(<item:minecraft:splash_potion>.withTag({Potion: "potionsmaster:platinum_sight" as string}), <potion:potionsmaster:platinum_sight>);
        removePotion(<item:minecraft:splash_potion>.withTag({Potion: "potionsmaster:crimsoniron_sight" as string}), <potion:potionsmaster:crimsoniron_sight>);
        removePotion(<item:minecraft:splash_potion>.withTag({Potion: "potionsmaster:allthemodium_sight" as string}), <potion:potionsmaster:allthemodium_sight>);
        removePotion(<item:minecraft:potion>.withTag({Potion: "potionsmaster:vibranium_sight" as string}), <potion:potionsmaster:vibranium_sight>);
        removePotion(<item:minecraft:potion>.withTag({Potion: "potionsmaster:unobtainium_sight" as string}), <potion:potionsmaster:unobtainium_sight>);
        removePotion(<item:minecraft:potion>.withTag({Potion: "potionsmaster:platinum_sight" as string}), <potion:potionsmaster:platinum_sight>);
        removePotion(<item:minecraft:potion>.withTag({Potion: "potionsmaster:crimsoniron_sight" as string}), <potion:potionsmaster:crimsoniron_sight>);
        removePotion(<item:minecraft:potion>.withTag({Potion: "potionsmaster:bismuth_sight" as string}), <potion:potionsmaster:bismuth_sight>);
        removePotion(<item:minecraft:potion>.withTag({Potion: "potionsmaster:allthemodium_sight" as string}), <potion:potionsmaster:allthemodium_sight>);
        removePotion(<item:minecraft:lingering_potion>.withTag({Potion: "potionsmaster:vibranium_sight" as string}), <potion:potionsmaster:vibranium_sight>);
        removePotion(<item:minecraft:lingering_potion>.withTag({Potion: "potionsmaster:unobtainium_sight" as string}), <potion:potionsmaster:unobtainium_sight>);
        removePotion(<item:minecraft:lingering_potion>.withTag({Potion: "potionsmaster:platinum_sight" as string}), <potion:potionsmaster:platinum_sight>);
        removePotion(<item:minecraft:lingering_potion>.withTag({Potion: "potionsmaster:crimsoniron_sight" as string}), <potion:potionsmaster:crimsoniron_sight>);
        removePotion(<item:minecraft:lingering_potion>.withTag({Potion: "potionsmaster:bismuth_sight" as string}), <potion:potionsmaster:bismuth_sight>);
        removePotion(<item:minecraft:lingering_potion>.withTag({Potion: "potionsmaster:allthemodium_sight" as string}), <potion:potionsmaster:allthemodium_sight>);
        remove(<item:minecraft:tipped_arrow>.withTag({Potion: "potionsmaster:crimsoniron_sight" as string}));
        remove(<item:minecraft:tipped_arrow>.withTag({Potion: "potionsmaster:platinum_sight" as string}));
        remove(<item:minecraft:tipped_arrow>.withTag({Potion: "potionsmaster:unobtainium_sight" as string}));
        remove(<item:minecraft:tipped_arrow>.withTag({Potion: "potionsmaster:vibranium_sight" as string}));
        remove(<item:spartanweaponry:arrow_wood_tipped>.withTag({Potion: "potionsmaster:bismuth_sight" as string}));
        remove(<item:spartanweaponry:arrow_wood_tipped>.withTag({Potion: "potionsmaster:crimsoniron_sight" as string}));
        remove(<item:spartanweaponry:arrow_wood_tipped>.withTag({Potion: "potionsmaster:platinum_sight" as string}));
        remove(<item:spartanweaponry:arrow_wood_tipped>.withTag({Potion: "potionsmaster:unobtainium_sight" as string}));
        remove(<item:spartanweaponry:arrow_wood_tipped>.withTag({Potion: "potionsmaster:vibranium_sight" as string}));
        remove(<item:spartanweaponry:arrow_iron_tipped>.withTag({Potion: "potionsmaster:crimsoniron_sight" as string}));
        remove(<item:spartanweaponry:arrow_iron_tipped>.withTag({Potion: "potionsmaster:platinum_sight" as string}));
        remove(<item:spartanweaponry:arrow_iron_tipped>.withTag({Potion: "potionsmaster:unobtainium_sight" as string}));
        remove(<item:spartanweaponry:arrow_iron_tipped>.withTag({Potion: "potionsmaster:vibranium_sight" as string}));
        remove(<item:spartanweaponry:arrow_iron_tipped>.withTag({Potion: "potionsmaster:bismuth_sight" as string}));
        remove(<item:spartanweaponry:arrow_diamond_tipped>.withTag({Potion: "potionsmaster:crimsoniron_sight" as string}));
        remove(<item:spartanweaponry:arrow_diamond_tipped>.withTag({Potion: "potionsmaster:platinum_sight" as string}));
        remove(<item:spartanweaponry:arrow_diamond_tipped>.withTag({Potion: "potionsmaster:unobtainium_sight" as string}));
        remove(<item:spartanweaponry:arrow_diamond_tipped>.withTag({Potion: "potionsmaster:vibranium_sight" as string}));
        remove(<item:spartanweaponry:arrow_diamond_tipped>.withTag({Potion: "potionsmaster:bismuth_sight" as string}));
        remove(<item:minecraft:tipped_arrow>.withTag({Potion: "potionsmaster:bismuth_sight" as string}));
        remove(<item:spartanweaponry:arrow_diamond_tipped>.withTag({Potion: "potionsmaster:allthemodium_sight" as string}));
        remove(<item:spartanweaponry:arrow_iron_tipped>.withTag({Potion: "potionsmaster:allthemodium_sight" as string}));
        remove(<item:spartanweaponry:arrow_wood_tipped>.withTag({Potion: "potionsmaster:allthemodium_sight" as string}));
        remove(<item:minecraft:tipped_arrow>.withTag({Potion: "potionsmaster:allthemodium_sight" as string}));
        remove(<item:spartanweaponry:bolt_tipped>.withTag({Potion: "potionsmaster:allthemodium_sight" as string}));
        remove(<item:spartanweaponry:bolt_tipped_diamond>.withTag({Potion: "potionsmaster:allthemodium_sight" as string}));
        remove(<item:spartanweaponry:bolt_tipped>.withTag({Potion: "potionsmaster:bismuth_sight" as string}));
        remove(<item:spartanweaponry:bolt_tipped_diamond>.withTag({Potion: "potionsmaster:bismuth_sight" as string}));
        remove(<item:spartanweaponry:bolt_tipped>.withTag({Potion: "potionsmaster:crimsoniron_sight" as string}));
        remove(<item:spartanweaponry:bolt_tipped_diamond>.withTag({Potion: "potionsmaster:crimsoniron_sight" as string}));
        remove(<item:spartanweaponry:bolt_tipped>.withTag({Potion: "potionsmaster:unobtainium_sight" as string}));
        remove(<item:spartanweaponry:bolt_tipped_diamond>.withTag({Potion: "potionsmaster:unobtainium_sight" as string}));
        remove(<item:spartanweaponry:bolt_tipped_diamond>.withTag({Potion: "potionsmaster:vibranium_sight" as string}));
        remove(<item:spartanweaponry:bolt_tipped>.withTag({Potion: "potionsmaster:vibranium_sight" as string}));
        remove(<item:supplementaries:bamboo_spikes_tipped>.withTag({Potion: "potionsmaster:vibranium_sight" as string}));
        remove(<item:supplementaries:bamboo_spikes_tipped>.withTag({Potion: "potionsmaster:unobtainium_sight" as string}));
        remove(<item:supplementaries:bamboo_spikes_tipped>.withTag({Potion: "potionsmaster:platinum_sight" as string}));
        remove(<item:supplementaries:bamboo_spikes_tipped>.withTag({Potion: "potionsmaster:crimsoniron_sight" as string}));
        remove(<item:supplementaries:bamboo_spikes_tipped>.withTag({Potion: "potionsmaster:bismuth_sight" as string}));
        remove(<item:supplementaries:bamboo_spikes_tipped>.withTag({Potion: "potionsmaster:allthemodium_sight" as string}));
        remove(<item:apotheosis:potion_charm>.withTag({Potion: "potionsmaster:unobtainium_sight" as string}));
        remove(<item:apotheosis:potion_charm>.withTag({Potion: "potionsmaster:vibranium_sight" as string}));
        remove(<item:apotheosis:potion_charm>.withTag({Potion: "potionsmaster:platinum_sight" as string}));
        remove(<item:apotheosis:potion_charm>.withTag({Potion: "potionsmaster:crimsoniron_sight" as string}));
        remove(<item:apotheosis:potion_charm>.withTag({Potion: "potionsmaster:allthemodium_sight" as string}));
        remove(<item:apotheosis:potion_charm>.withTag({Potion: "potionsmaster:bismuth_sight" as string}));
#f&a
    #removals
        remove(<item:forbidden_arcanus:spectral_eye_amulet>);
    #items
        #aqua drag scale
            craftingTable.removeRecipe(<item:forbidden_arcanus:aquatic_dragon_scale>);
            craftingTable.addShaped("aquatic_dragon_scale_edit", <item:forbidden_arcanus:aquatic_dragon_scale>, [
                [<item:forbidden_arcanus:dragon_scale>, <tag:items:forge:dusts/diamond>],
                [<item:kubejs:omega_dust>, <item:forbidden_arcanus:mundabitur_dust>]]);
        #mundabitur dust
            craftingTable.removeRecipe(<item:forbidden_arcanus:mundabitur_dust>);
            craftingTable.addShapeless("mundabitur_dust_edit", <item:forbidden_arcanus:mundabitur_dust>, [<item:forbidden_arcanus:arcane_crystal_dust>, <item:botania:pixie_dust>, <item:minecraft:blaze_powder>, <item:minecraft:phantom_membrane>, redstone, <item:create:chromatic_compound>, <item:mekanism:teleportation_core>, <item:rftoolsbase:infused_diamond>, <item:thermal:tar>]);
#easy trading
    #villagers
        #items
            #trader
                craftingTable.removeRecipe(<item:easy_villagers:trader>);
                craftingTable.addShaped("trader_edit", <item:easy_villagers:trader>, [
                    [<item:botania:mana_glass>, <item:botania:mana_glass>, <item:botania:mana_glass>],
                    [<item:botania:mana_glass>, <item:minecraft:netherite_ingot>, <item:botania:mana_glass>],
                    [ironPlate, ironPlate, ironPlate]]);
            #auto trader
                craftingTable.removeRecipe(<item:easy_villagers:auto_trader>);
                craftingTable.addShaped("auto_trader_edit", <item:easy_villagers:auto_trader>, [
                    [<item:botania:elf_glass>, <item:botania:elf_glass>, <item:botania:elf_glass>],
                    [<item:botania:elf_glass>, <item:minecraft:netherite_block>, <item:botania:elf_glass>],
                    [steelPlate, <item:draconicevolution:small_chaos_frag>, steelPlate]]);
            #iron farm
                craftingTable.removeRecipe(<item:easy_villagers:iron_farm>);
                craftingTable.addShaped("iron_farm_edit", <item:easy_villagers:iron_farm>, [
                    [<item:botania:mana_glass>, <item:botania:mana_glass>, <item:botania:mana_glass>],
                    [<item:botania:mana_glass>, <item:minecraft:lava_bucket>, <item:botania:mana_glass>],
                    [steelPlate, <item:draconicevolution:small_chaos_frag>, steelPlate]]);
            #converter
                craftingTable.removeRecipe(<item:easy_villagers:converter>);
                craftingTable.addShaped("converter_edit", <item:easy_villagers:converter>, [
                    [<item:botania:mana_glass>, <item:botania:mana_glass>, <item:botania:mana_glass>],
                    [<item:botania:mana_glass>, <item:minecraft:zombie_head>, <item:botania:mana_glass>],
                    [ironPlate, <item:kubejs:omega_dust>, ironPlate]]);
            #breeder
                craftingTable.removeRecipe(<item:easy_villagers:breeder>);
                craftingTable.addShaped("breeder_edit", <item:easy_villagers:breeder>, [
                    [<item:botania:mana_glass>, <item:botania:mana_glass>, <item:botania:mana_glass>],
                    [<item:botania:mana_glass>, <tag:items:minecraft:beds>, <item:botania:mana_glass>],
                    [ironPlate, <item:kubejs:omega_dust>, ironPlate]]);
            #farmer
                craftingTable.removeRecipe(<item:easy_villagers:farmer>);
                craftingTable.addShaped("farmer_edit", <item:easy_villagers:farmer>, [
                    [<item:botania:mana_glass>, <item:botania:mana_glass>, <item:botania:mana_glass>],
                    [<item:botania:mana_glass>, <item:cyclic:soil>, <item:botania:mana_glass>],
                    [<item:kubejs:alloy_chaotic>, <item:cyclic:terra_preta>, <item:kubejs:alloy_chaotic>]]);
            #incubator
                craftingTable.removeRecipe(<item:easy_villagers:incubator>);
                craftingTable.addShaped("incubator_edit", <item:easy_villagers:incubator>, [
                    [<item:botania:mana_glass>, <item:botania:mana_glass>, <item:botania:mana_glass>],
                    [<item:botania:mana_glass>, air, <item:botania:mana_glass>],
                    [ironPlate, <item:minecraft:white_wool>, ironPlate]]);
    #piglins
        #barterer
            craftingTable.removeRecipe(<item:easy_piglins:barterer>);
            craftingTable.addShaped("barterer_edit", <item:easy_piglins:barterer>, [
                [<item:thermal:signalum_glass>, <item:thermal:signalum_glass>, <item:thermal:signalum_glass>],
                [<item:thermal:signalum_glass>, <item:immersiveengineering:sheetmetal_gold>, <item:thermal:signalum_glass>],
                [ironPlate, <item:minecraft:gilded_blackstone>, ironPlate]]);
#nomadic
    #tent canvas
        craftingTable.removeRecipe(<item:nomadictents:tent_canvas>);
        craftingTable.addShaped("tent_canvas_edit", <item:nomadictents:tent_canvas>, [
            [<tag:items:forge:wool>, <tag:items:forge:wool>, <tag:items:forge:wool>],
            [<tag:items:forge:wool>, <item:immersiveengineering:hammer>.anyDamage(), <tag:items:forge:wool>],
            [<tag:items:forge:wool>, <tag:items:forge:wool>, <tag:items:forge:wool>]]);
    #mallet
        craftingTable.removeRecipe(<item:nomadictents:mallet>);
        craftingTable.addShapedMirrored("mallet_edit", <item:nomadictents:mallet>, [
            [air, <item:kubejs:omega_dust>, <item:nomadictents:tent_canvas>],
            [air, <item:minecraft:stick>, <item:kubejs:omega_dust>],
            [<item:minecraft:stick>, air, air]]);
    #golden mallet
        craftingTable.removeRecipe(<item:nomadictents:golden_mallet>);
        craftingTable.addShapedMirrored("golden_mallet_edit", <item:nomadictents:golden_mallet>, [
            [air, ccc, <item:nomadictents:tent_canvas>],
            [air, <item:minecraft:stick>, ccc],
            [<item:minecraft:stick>, air, air]]);
#drawers
    #items
        #upgrades
            #obsidian
                craftingTable.removeRecipe(<item:storagedrawers:obsidian_storage_upgrade>);
                craftingTable.addShaped("obsidian_upgrade_edit", <item:storagedrawers:obsidian_storage_upgrade>, [
                    [<item:minecraft:stick>, <item:minecraft:stick>, <item:minecraft:stick>],
                    [<item:minecraft:diamond_block>, <item:storagedrawers:upgrade_template>, <item:minecraft:diamond_block>],
                    [<item:minecraft:stick>, <item:minecraft:stick>, <item:minecraft:stick>]]);
            #iron
                craftingTable.removeRecipe(<item:storagedrawers:iron_storage_upgrade>);
                craftingTable.addShaped("iron_upgrade_edit", <item:storagedrawers:iron_storage_upgrade>, [
                    [<item:minecraft:stick>, <item:minecraft:stick>, <item:minecraft:stick>],
                    [<item:kubejs:compressed_obsidian>, <item:storagedrawers:obsidian_storage_upgrade>, <item:kubejs:compressed_obsidian>],
                    [<item:minecraft:stick>, <item:minecraft:stick>, <item:minecraft:stick>]]);
            #gold
                craftingTable.removeRecipe(<item:storagedrawers:gold_storage_upgrade>);
                craftingTable.addShaped("gold_upgrade_edit", <item:storagedrawers:gold_storage_upgrade>, [
                    [<item:minecraft:stick>, <item:minecraft:stick>, <item:minecraft:stick>],
                    [<item:kubejs:omega_dust>, <item:storagedrawers:iron_storage_upgrade>, <item:kubejs:omega_dust>],
                    [<item:minecraft:stick>, <item:minecraft:stick>, <item:minecraft:stick>]]);
            #diamond
                craftingTable.removeRecipe(<item:storagedrawers:diamond_storage_upgrade>);
                craftingTable.addShaped("diamond_upgrade_edit", <item:storagedrawers:diamond_storage_upgrade>, [
                    [<item:minecraft:stick>, <item:minecraft:stick>, <item:minecraft:stick>],
                    [<item:moremekanismprocessing:tungsten_ingot>, <item:storagedrawers:gold_storage_upgrade>, <item:moremekanismprocessing:tungsten_ingot>],
                    [<item:minecraft:stick>, <item:minecraft:stick>, <item:minecraft:stick>]]);
            #emerald
                craftingTable.removeRecipe(<item:storagedrawers:emerald_storage_upgrade>);
                craftingTable.addShaped("emerald_upgrade_edit", <item:storagedrawers:emerald_storage_upgrade>, [
                    [<item:minecraft:stick>, <item:minecraft:stick>, <item:minecraft:stick>],
                    [<item:kubejs:alloy_chaotic>, <item:storagedrawers:diamond_storage_upgrade>, <item:kubejs:alloy_chaotic>],
                    [<item:minecraft:stick>, <item:minecraft:stick>, <item:minecraft:stick>]]);
            #base
                craftingTable.removeRecipe(<item:storagedrawers:upgrade_template>);
                craftingTable.addShaped("upgrade_template_edit", <item:storagedrawers:upgrade_template>, [
                    [<item:minecraft:stick>, <item:minecraft:stick>, <item:minecraft:stick>],
                    [<item:minecraft:emerald_block>, <tag:items:storagedrawers:drawers>, <item:minecraft:emerald_block>],
                    [<item:minecraft:stick>, <item:minecraft:stick>, <item:minecraft:stick>]]);
        #drawers
                drawerVariations("oak");
                drawerVariations("spruce");
                drawerVariations("birch");
                drawerVariations("jungle");
                drawerVariations("acacia");
                drawerVariations("dark_oak");
                drawerVariations("crimson");
                drawerVariations("warped");
        #framed
            #full
                craftingTable.removeRecipe(<item:framedcompactdrawers:framed_full_one>);
                craftingTable.addShaped("framed_full_one_drawer_edit", <item:framedcompactdrawers:framed_full_one>, [
                    [<tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>],
                    [<tag:items:forge:rods/wooden>, <item:storagedrawers:oak_full_drawers_1>, <tag:items:forge:rods/wooden>],
                    [<tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>]]);
            #double
                craftingTable.removeRecipe(<item:framedcompactdrawers:framed_full_two>);
                craftingTable.addShaped("framed_full_two_drawer_edit", <item:framedcompactdrawers:framed_full_two>, [
                    [<tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>],
                    [<tag:items:forge:rods/wooden>, <item:storagedrawers:oak_full_drawers_2>, <tag:items:forge:rods/wooden>],
                    [<tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>]]);
            #quad
                craftingTable.removeRecipe(<item:framedcompactdrawers:framed_full_four>);
                craftingTable.addShaped("framed_full_four_drawer_edit", <item:framedcompactdrawers:framed_full_four>, [
                    [<tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>],
                    [<tag:items:forge:rods/wooden>, <item:storagedrawers:oak_full_drawers_4>, <tag:items:forge:rods/wooden>],
                    [<tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>]]);
            #full small
                craftingTable.removeRecipe(<item:framedcompactdrawers:framed_half_one>);
                craftingTable.addShaped("framed_half_one_drawer_edit", <item:framedcompactdrawers:framed_half_one>, [
                    [<tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>],
                    [<tag:items:forge:rods/wooden>, <item:storagedrawers:oak_half_drawers_1>, <tag:items:forge:rods/wooden>],
                    [<tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>]]);
            #double small
                craftingTable.removeRecipe(<item:framedcompactdrawers:framed_half_two>);
                craftingTable.addShaped("framed_half_two_drawer_edit", <item:framedcompactdrawers:framed_half_two>, [
                    [<tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>],
                    [<tag:items:forge:rods/wooden>, <item:storagedrawers:oak_half_drawers_2>, <tag:items:forge:rods/wooden>],
                    [<tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>]]);
            #quad small
                craftingTable.removeRecipe(<item:framedcompactdrawers:framed_half_four>);
                craftingTable.addShaped("framed_half_four_drawer_edit", <item:framedcompactdrawers:framed_half_four>, [
                    [<tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>],
                    [<tag:items:forge:rods/wooden>, <item:storagedrawers:oak_half_drawers_4>, <tag:items:forge:rods/wooden>],
                    [<tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>, <tag:items:forge:rods/wooden>]]);
        #compacting
            craftingTable.removeRecipe(<item:storagedrawers:compacting_drawers_3>);
            craftingTable.addShaped("compacting_drawer_edit", <item:storagedrawers:compacting_drawers_3>, [
                [steelPlate, <item:moremekanismprocessing:tungsten_ingot>, steelPlate],
                [<tag:items:storagedrawers:drawers>, <item:kubejs:compressed_obsidian>, <tag:items:storagedrawers:drawers>],
                [steelPlate, <item:moremekanismprocessing:tungsten_ingot>, steelPlate]]);
        #controller
            craftingTable.removeRecipe(<item:storagedrawers:controller>);
            craftingTable.addShaped("controller_edit", <item:storagedrawers:controller>, [
                [steelPlate, <item:moremekanismprocessing:tungsten_ingot>, steelPlate],
                [<item:moremekanismprocessing:tungsten_ingot>, <tag:items:storagedrawers:drawers>, <item:moremekanismprocessing:tungsten_ingot>],
                [steelPlate, <item:kubejs:alloy_chaotic>, steelPlate]]);
        #slave
            craftingTable.removeRecipe(<item:storagedrawers:controller_slave>);
            craftingTable.addShaped("controller_slave_edit", <item:storagedrawers:controller_slave> * 2, [
                [steelPlate, signalumPlate, steelPlate],
                [signalumPlate, <tag:items:storagedrawers:drawers>, signalumPlate],
                [steelPlate, <item:moremekanismprocessing:tungsten_ingot>, steelPlate]]);
#solar flux reborn
    #items
        #upgrades
            #capacity
                craftingTable.removeRecipe(<item:solarflux:capacity_upgrade>);
                craftingTable.addShaped("capacity_upgrade_edit", <item:solarflux:capacity_upgrade>, [
                    [<item:draconicevolution:wyvern_energy_module>, <item:solarflux:blank_upgrade>, <item:draconicevolution:wyvern_energy_module>]]);
            #transfer
                craftingTable.removeRecipe(<item:solarflux:transfer_rate_upgrade>);
                craftingTable.addShaped("transfer_rate_upgrade_edit", <item:solarflux:transfer_rate_upgrade>, [
                    [<item:draconicevolution:wyvern_io_crystal>, <item:solarflux:blank_upgrade>, <item:draconicevolution:wyvern_io_crystal>]]);
            #efficiency
                craftingTable.removeRecipe(<item:solarflux:efficiency_upgrade>);
                craftingTable.addShaped("efficiency_upgrade_edit", <item:solarflux:efficiency_upgrade>, [
                    [<item:draconicevolution:wyvern_speed_module>, <item:solarflux:blank_upgrade>, <item:draconicevolution:wyvern_speed_module>]]);
            #blank
                craftingTable.removeRecipe(<item:solarflux:blank_upgrade>);
                craftingTable.addShaped("blank_upgrade_edit", <item:solarflux:blank_upgrade>, [
                    [<item:minecraft:iron_block>, <item:minecraft:iron_block>, <item:minecraft:iron_block>],
                    [<item:minecraft:iron_block>, <item:solarflux:photovoltaic_cell_3>, <item:minecraft:iron_block>],
                    [<item:minecraft:iron_block>, <item:minecraft:iron_block>, <item:minecraft:iron_block>]]);
        #photovoltaic cell
            #1
                craftingTable.removeRecipe(<item:solarflux:photovoltaic_cell_1>);
                craftingTable.addShaped("photovoltaic_cell_1_edit", <item:solarflux:photovoltaic_cell_1>, [
                    [<tag:items:forge:glass>, <tag:items:forge:glass>, <tag:items:forge:glass>],
                    [<item:minecraft:glowstone_dust>, <item:minecraft:lapis_lazuli>, <item:minecraft:glowstone_dust>],
                    [<item:solarflux:mirror>, <item:solarflux:mirror>, <item:solarflux:mirror>]]);
            #2
                craftingTable.removeRecipe(<item:solarflux:photovoltaic_cell_2>);
                craftingTable.addShaped("photovoltaic_cell_2_edit", <item:solarflux:photovoltaic_cell_2>, [
                    [<item:thermal:obsidian_glass>, <item:thermal:obsidian_glass>, <item:thermal:obsidian_glass>],
                    [<item:minecraft:glowstone_dust>, <item:rftoolscontrol:card_base>, <item:minecraft:glowstone_dust>],
                    [<item:minecraft:diamond>, <item:solarflux:photovoltaic_cell_1>, <item:minecraft:diamond>]]);
            #3
                craftingTable.removeRecipe(<item:solarflux:photovoltaic_cell_3>);
                craftingTable.addShaped("photovoltaic_cell_3_edit", <item:solarflux:photovoltaic_cell_3>, [
                    [<item:thermal:signalum_glass>, <item:thermal:signalum_glass>, <item:thermal:signalum_glass>],
                    [<item:minecraft:glowstone_dust>, <item:rftoolscontrol:card_base>, <item:minecraft:glowstone_dust>],
                    [<item:kubejs:compressed_obsidian>, <item:solarflux:photovoltaic_cell_2>, <item:kubejs:compressed_obsidian>]]);
            #4
                craftingTable.removeRecipe(<item:solarflux:photovoltaic_cell_4>);
                craftingTable.addShaped("photovoltaic_cell_4_edit", <item:solarflux:photovoltaic_cell_4>, [
                    [<item:solarflux:blazing_coating>, <item:solarflux:blazing_coating>, <item:solarflux:blazing_coating>],
                    [<item:minecraft:glowstone_dust>, <item:rftoolscontrol:card_base>, <item:minecraft:glowstone_dust>],
                    [<item:kubejs:omega_dust>, <item:solarflux:photovoltaic_cell_3>, <item:kubejs:omega_dust>]]);
            #5
                craftingTable.removeRecipe(<item:solarflux:photovoltaic_cell_5>);
                craftingTable.addShaped("photovoltaic_cell_5_edit", <item:solarflux:photovoltaic_cell_5>, [
                    [<item:solarflux:emerald_glass>, <item:solarflux:emerald_glass>, <item:solarflux:emerald_glass>],
                    [<item:minecraft:glowstone_dust>, <item:rftoolscontrol:card_base>, <item:minecraft:glowstone_dust>],
                    [<item:moremekanismprocessing:tungsten_ingot>, <item:solarflux:photovoltaic_cell_4>, <item:moremekanismprocessing:tungsten_ingot>]]);
            #6
                craftingTable.removeRecipe(<item:solarflux:photovoltaic_cell_6>);
                craftingTable.addShaped("photovoltaic_cell_6_edit", <item:solarflux:photovoltaic_cell_6>, [
                    [<item:solarflux:ender_glass>, <item:solarflux:ender_glass>, <item:solarflux:ender_glass>],
                    [<item:minecraft:glowstone_dust>, <item:rftoolscontrol:card_base>, <item:minecraft:glowstone_dust>],
                    [<item:kubejs:alloy_chaotic>, <item:solarflux:photovoltaic_cell_5>, <item:kubejs:alloy_chaotic>]]);
            #blazing coating
                craftingTable.removeRecipe(<item:solarflux:blazing_coating>);
                craftingTable.addShaped("blazing_coating_edit", <item:solarflux:blazing_coating>, [
                    [<item:solarflux:mirror>],
                    [<item:powah:crystal_blazing>],
                    [<item:solarflux:mirror>]]);
            #emerald glass
                craftingTable.removeRecipe(<item:solarflux:emerald_glass>);
                craftingTable.addShaped("emerald_glass_edit", <item:solarflux:emerald_glass>, [
                    [<item:solarflux:mirror>],
                    [<item:powah:crystal_spirited>],
                    [<item:solarflux:mirror>]]);
            #ender glass
                craftingTable.removeRecipe(<item:solarflux:ender_glass>);
                craftingTable.addShaped("ender_glass_edit", <item:solarflux:ender_glass>, [
                    [<item:solarflux:emerald_glass>],
                    [<item:cyclic:ender_eye_reuse>],
                    [<item:solarflux:emerald_glass>]]);
            #mirror
                craftingTable.removeRecipe(<item:solarflux:mirror>);
                craftingTable.addShaped("mirror_edit", <item:solarflux:mirror> * 3, [
                    [<tag:items:forge:glass>, <tag:items:forge:glass>, <tag:items:forge:glass>],
                    [air, ironPlate, air]]);
        #Solar panel
            #2
                craftingTable.removeRecipe(<item:solarflux:sp_2>);
                craftingTable.addShaped("sp_2_edit", <item:solarflux:sp_2>, [
                    [<item:solarflux:sp_1>, <item:solarflux:sp_1>, <item:solarflux:sp_1>],
                    [<item:solarflux:sp_1>, steelPlate, <item:solarflux:sp_1>],
                    [<item:solarflux:sp_1>, <item:solarflux:sp_1>, <item:solarflux:sp_1>]]);
            #3
                craftingTable.removeRecipe(<item:solarflux:sp_3>);
                craftingTable.addShaped("sp_3_edit", <item:solarflux:sp_3> * 2, [
                    [<item:solarflux:photovoltaic_cell_1>, <item:solarflux:photovoltaic_cell_1>, <item:solarflux:photovoltaic_cell_1>],
                    [<item:solarflux:sp_2>, <item:pneumaticcraft:compressed_iron_block>, <item:solarflux:sp_2>],
                    [<item:solarflux:sp_2>, <tag:items:forge:storage_blocks/steel>, <item:solarflux:sp_2>]]);
            #4
                craftingTable.removeRecipe(<item:solarflux:sp_4>);
                craftingTable.addShaped("sp_4_edit", <item:solarflux:sp_4> * 2, [
                    [<item:solarflux:photovoltaic_cell_2>, <item:solarflux:photovoltaic_cell_2>, <item:solarflux:photovoltaic_cell_2>],
                    [<item:solarflux:sp_3>, <item:forbidden_arcanus:arcane_gold_ingot>, <item:solarflux:sp_3>],
                    [<item:solarflux:sp_3>, <item:minecraft:diamond_block>, <item:solarflux:sp_3>]]);
            #5
                craftingTable.removeRecipe(<item:solarflux:sp_5>);
                craftingTable.addShaped("sp_5_edit", <item:solarflux:sp_5> * 2, [
                    [<item:solarflux:photovoltaic_cell_3>, <item:solarflux:photovoltaic_cell_3>, <item:solarflux:photovoltaic_cell_3>],
                    [<item:solarflux:sp_4>, <item:botania:dragonstone>, <item:solarflux:sp_4>],
                    [<item:solarflux:sp_4>, <item:minecraft:netherite_block>, <item:solarflux:sp_4>]]);
            #6
                craftingTable.removeRecipe(<item:solarflux:sp_6>);
                craftingTable.addShaped("sp_6_edit", <item:solarflux:sp_6> * 2, [
                    [<item:solarflux:photovoltaic_cell_4>, <item:solarflux:photovoltaic_cell_4>, <item:solarflux:photovoltaic_cell_4>],
                    [<item:solarflux:sp_5>, <item:mekanism:ultimate_control_circuit>, <item:solarflux:sp_5>],
                    [<item:solarflux:sp_5>, <item:thermal:signalum_block>, <item:solarflux:sp_5>]]);
            #7
                craftingTable.removeRecipe(<item:solarflux:sp_7>);
                craftingTable.addShaped("sp_7_edit", <item:solarflux:sp_7> * 2, [
                    [<item:solarflux:photovoltaic_cell_5>, <item:solarflux:photovoltaic_cell_5>, <item:solarflux:photovoltaic_cell_5>],
                    [<item:solarflux:sp_6>, <item:mekanism:hdpe_sheet>, <item:solarflux:sp_6>],
                    [<item:solarflux:sp_6>, <item:thermal:lumium_block>, <item:solarflux:sp_6>]]);
            #8
                craftingTable.removeRecipe(<item:solarflux:sp_8>);
                craftingTable.addShaped("sp_8_edit", <item:solarflux:sp_8>, [
                    [<item:solarflux:photovoltaic_cell_6>, <item:solarflux:photovoltaic_cell_6>, <item:solarflux:photovoltaic_cell_6>],
                    [<item:solarflux:sp_7>, <item:pneumaticcraft:plastic>, <item:solarflux:sp_7>],
                    [<item:solarflux:sp_7>, <item:thermal:enderium_block>, <item:solarflux:sp_7>]]);
            #wyvern
                craftingTable.removeRecipe(<item:solarflux:sp_de.wyvern>);
                craftingTable.addShaped("sp_wyvern_edit", <item:solarflux:sp_de.wyvern> * 2, [
                    [<item:draconicevolution:wyvern_energy_core>, <item:draconicevolution:wyvern_energy_core>, <item:draconicevolution:wyvern_energy_core>],
                    [<item:solarflux:sp_8>, <item:draconicevolution:wyvern_core>, <item:solarflux:sp_8>],
                    [<item:solarflux:sp_8>, <item:forbidden_arcanus:dark_nether_star_block>, <item:solarflux:sp_8>]]);
            #draconic
                craftingTable.removeRecipe(<item:solarflux:sp_de.draconic>);
                craftingTable.addShaped("sp_draconic_edit", <item:solarflux:sp_de.draconic> * 2, [
                    [<item:draconicevolution:draconic_energy_core>, <item:draconicevolution:draconic_energy_core>, <item:draconicevolution:draconic_energy_core>],
                    [<item:solarflux:sp_de.wyvern>, <item:draconicevolution:awakened_core>, <item:solarflux:sp_de.wyvern>],
                    [<item:solarflux:sp_de.wyvern>, <item:draconicevolution:awakened_draconium_block>, <item:solarflux:sp_de.wyvern>]]);
#dark utilities
    #items
        #vacuum hopper
            craftingTable.removeRecipe(<item:darkutils:ender_hopper>);
            craftingTable.addShaped("ender_hopper_edit", <item:darkutils:ender_hopper>, [
                [<item:kubejs:compressed_obsidian>, <item:cyclic:ender_eye_reuse>, <item:kubejs:compressed_obsidian>],
                [<item:kubejs:compressed_obsidian>, <item:minecraft:hopper>, <item:kubejs:compressed_obsidian>],
                [air, <item:kubejs:compressed_obsidian>, air]]);
        #gluttony charm
            craftingTable.removeRecipe(<item:darkutils:charm_gluttony>);
            craftingTable.addShaped("charm_gluttony_edit", <item:darkutils:charm_gluttony>, [
                [<item:botania:manaweave_cloth>, <item:minecraft:cookie>, <item:botania:manaweave_cloth>],
                [<item:pamhc2foodcore:doughitem>, <item:minecraft:golden_apple>, <item:minecraft:bread>],
                [<item:botania:manaweave_cloth>, <tag:items:forge:salt>, <item:botania:manaweave_cloth>]]);
        #exp charm
            craftingTable.removeRecipe(<item:darkutils:charm_experience>);
            craftingTable.addShaped("charm_experience_edit", <item:darkutils:charm_experience>, [
                [<item:botania:manaweave_cloth>, <item:minecraft:emerald>, <item:botania:manaweave_cloth>],
                [<item:minecraft:emerald>, <item:minecraft:experience_bottle>, <item:minecraft:emerald>],
                [<item:botania:manaweave_cloth>, <item:minecraft:emerald>, <item:botania:manaweave_cloth>]]);
        #portal charm
            craftingTable.removeRecipe(<item:darkutils:charm_portal>);
            craftingTable.addShaped("charm_portal_edit", <item:darkutils:charm_portal>, [
                [<item:botania:manaweave_cloth>, <item:minecraft:obsidian>, <item:botania:manaweave_cloth>],
                [<item:minecraft:obsidian>, <item:minecraft:end_crystal>, <item:minecraft:obsidian>],
                [<item:botania:manaweave_cloth>, <item:minecraft:obsidian>, <item:botania:manaweave_cloth>]]);
        #sleep charm
            craftingTable.removeRecipe(<item:darkutils:charm_sleep>);
            craftingTable.addShaped("charm_sleep_edit", <item:darkutils:charm_sleep>, [
                [<item:botania:manaweave_cloth>, <item:minecraft:white_dye>, <item:botania:manaweave_cloth>],
                [<item:minecraft:black_dye>, <item:minecraft:phantom_membrane>, <item:minecraft:yellow_dye>],
                [<item:botania:manaweave_cloth>, <item:minecraft:red_dye>, <item:botania:manaweave_cloth>]]);
#pams
    #items
        #skillet
            craftingTable.removeRecipe(<item:pamhc2foodcore:skilletitem>);
            craftingTable.addShaped("skilletitem_edit", <item:pamhc2foodcore:skilletitem>, [
                [<item:immersiveengineering:blastbrick>, air, air],
                [air, <tag:items:forge:rods/wooden>, air],
                [air, air, <tag:items:forge:rods/wooden>]]);
        #sauce pan
            craftingTable.removeRecipe(<item:pamhc2foodcore:saucepanitem>);
            craftingTable.addShaped("saucepanitem_edit", <item:pamhc2foodcore:saucepanitem>, [
                [<tag:items:forge:rods/wooden>, <item:immersiveengineering:blastbrick>, air]]);
        #pot
            craftingTable.removeRecipe(<item:pamhc2foodcore:potitem>);
            craftingTable.addShaped("potitem_edit", <item:pamhc2foodcore:potitem>, [
                [<tag:items:forge:rods/wooden>, <item:immersiveengineering:blastbrick>, <item:immersiveengineering:blastbrick>],
                [air, <item:immersiveengineering:blastbrick>, <item:immersiveengineering:blastbrick>]]);
        #mixing bowl
            craftingTable.removeRecipe(<item:pamhc2foodcore:mixingbowlitem>);
            craftingTable.addShaped("mixingbowlitem_edit", <item:pamhc2foodcore:mixingbowlitem>, [
                [<item:cfm:oak_crate>, <tag:items:forge:rods/wooden>, <item:cfm:oak_crate>],
                [air, <item:cfm:oak_crate>, air]]);
        #grinder
            craftingTable.removeRecipe(<item:pamhc2foodcore:grinderitem>);
            craftingTable.addShaped("grinderitem_edit", <item:pamhc2foodcore:grinderitem>, [
                [<item:immersiveengineering:blastbrick>, <tag:items:forge:rods/wooden>, <item:immersiveengineering:blastbrick>],
                [air, <item:immersiveengineering:blastbrick>, air]]);
        #juicer
            craftingTable.removeRecipe(<item:pamhc2foodcore:juiceritem>);
            craftingTable.addShaped("juiceritem_edit", <item:pamhc2foodcore:juiceritem>, [
                [air, <item:immersiveengineering:blastbrick>, air],
                [<item:immersiveengineering:blastbrick>, <item:immersiveengineering:blastbrick>, <item:immersiveengineering:blastbrick>]]);
        #cutting board
            craftingTable.removeRecipe(<item:pamhc2foodcore:cuttingboarditem>);
            craftingTable.addShaped("cuttingboarditem_edit", <item:pamhc2foodcore:cuttingboarditem>, [
                [<item:immersiveengineering:blastbrick>, air, air],
                [air, <tag:items:forge:rods/wooden>, air],
                [air, air, <item:cfm:oak_crate>]]);
        #bakeware
            craftingTable.removeRecipe(<item:pamhc2foodcore:bakewareitem>);
            craftingTable.addShaped("bakewareitem_edit", <item:pamhc2foodcore:bakewareitem>, [
                [<item:immersiveengineering:blastbrick>, <item:immersiveengineering:blastbrick>, <item:immersiveengineering:blastbrick>],
                [<item:immersiveengineering:blastbrick>, air, <item:immersiveengineering:blastbrick>],
                [<item:immersiveengineering:blastbrick>, <item:immersiveengineering:blastbrick>, <item:immersiveengineering:blastbrick>]]);
#extreme reactors
    #replacer
        Replacer.forMods("bigreactors")
            .replace(<tag:items:forge:ingots/steel>, steelPlate)
            .replace(<item:minecraft:iron_ingot>, ironPlate)
            .replace(<item:minecraft:gold_ingot>, goldPlate)
            .execute();
#simple storage
    #items
        #inventory
            craftingTable.removeRecipe(<item:storagenetwork:inventory>);
            craftingTable.addShaped("inventory_edit", <item:storagenetwork:inventory>, [
                [<item:thermal:signalum_ingot>, <item:storagenetwork:kabel>, <item:thermal:signalum_ingot>],
                [<item:storagenetwork:kabel>, <item:cyclic:wireless_receiver>, <item:storagenetwork:kabel>],
                [<item:thermal:signalum_ingot>, <item:storagenetwork:kabel>, <item:thermal:signalum_ingot>]]);
        #request table
            craftingTable.removeRecipe(<item:storagenetwork:request>);
            craftingTable.addShaped("request_edit", <item:storagenetwork:request>, [
                [<item:kubejs:compressed_obsidian>, <item:storagenetwork:inventory>, <item:kubejs:compressed_obsidian>],
                [<item:storagenetwork:inventory>, <item:kubejs:alloy_chaotic>, <item:storagenetwork:inventory>],
                [<item:kubejs:compressed_obsidian>, <item:storagenetwork:inventory>, <item:kubejs:compressed_obsidian>]]);
        #network root
            craftingTable.removeRecipe(<item:storagenetwork:master>);
            craftingTable.addShaped("master_edit", <item:storagenetwork:master>, [
                [<item:kubejs:alloy_chaotic>, <item:storagenetwork:kabel>, <item:kubejs:alloy_chaotic>],
                [<item:storagenetwork:kabel>, <item:rftoolscontrol:cpu_core_500>, <item:storagenetwork:kabel>],
                [<item:kubejs:alloy_chaotic>, <item:storagenetwork:kabel>, <item:kubejs:alloy_chaotic>]]);
        #remote
            craftingTable.removeRecipe(<item:storagenetwork:inventory_remote>);
            craftingTable.addShaped("inventory_remote_edit", <item:storagenetwork:inventory_remote>, [
                [<tag:items:forge:slimeballs>, <item:minecraft:glowstone_dust>, <tag:items:forge:slimeballs>],
                [<item:forbidden_arcanus:arcane_gold_ingot>, <item:storagenetwork:master>, <item:forbidden_arcanus:arcane_gold_ingot>],
                [<tag:items:forge:slimeballs>, air, <tag:items:forge:slimeballs>]]);
        #crafting remote
            craftingTable.removeRecipe(<item:storagenetwork:crafting_remote>);
            craftingTable.addShaped("crafting_remote_edit", <item:storagenetwork:crafting_remote>, [
                [<item:mekanism:hdpe_sheet>, <item:immersiveengineering:ingot_hop_graphite>, <item:mekanism:hdpe_sheet>],
                [<item:immersiveengineering:ingot_hop_graphite>, <item:storagenetwork:inventory_remote>, <item:immersiveengineering:ingot_hop_graphite>],
                [<item:mekanism:hdpe_sheet>, <item:kubejs:chaotic_control_circuit>, <item:mekanism:hdpe_sheet>]]);
        #cables
            #cable
                craftingTable.removeRecipe(<item:storagenetwork:kabel>);
                craftingTable.addShaped("kabel_edit", <item:storagenetwork:kabel> * 8, [
                    [<item:minecraft:stone_slab>, <item:minecraft:stone_slab>, <item:minecraft:stone_slab>],
                    [ironPlate, air, ironPlate],
                    [<item:minecraft:stone_slab>, <item:minecraft:stone_slab>, <item:minecraft:stone_slab>]]);
            #link cable
                craftingTable.removeRecipe(<item:storagenetwork:storage_kabel>);
                craftingTable.addShaped("storage_kabel_edit", <item:storagenetwork:storage_kabel> * 4, [
                    [air, <item:storagenetwork:kabel>, air],
                    [<item:storagenetwork:kabel>, <item:kubejs:compressed_obsidian>, <item:storagenetwork:kabel>],
                    [air, <item:storagenetwork:kabel>, air]]);
            #import cable
                craftingTable.removeRecipe(<item:storagenetwork:import_kabel>);
                craftingTable.addShaped("import_kabel_edit", <item:storagenetwork:import_kabel> * 4, [
                    [zincPlate, <item:storagenetwork:kabel>, zincPlate],
                    [<item:storagenetwork:kabel>, <item:minecraft:hopper>, <item:storagenetwork:kabel>],
                    [zincPlate, <item:storagenetwork:kabel>, zincPlate]]);
            #filtered import cable
                craftingTable.removeRecipe(<item:storagenetwork:import_filter_kabel>);
                craftingTable.addShaped("import_filter_kabel_edit", <item:storagenetwork:import_filter_kabel> * 4, [
                    [<item:moremekanismprocessing:tungsten_ingot>, <item:storagenetwork:import_kabel>, <item:moremekanismprocessing:tungsten_ingot>],
                    [<item:storagenetwork:import_kabel>, <item:rftoolsbase:filter_module>, <item:storagenetwork:import_kabel>],
                    [<item:moremekanismprocessing:tungsten_ingot>, <item:storagenetwork:import_kabel>, <item:moremekanismprocessing:tungsten_ingot>]]);
            #filtered link cable
                craftingTable.removeRecipe(<item:storagenetwork:filter_kabel>);
                craftingTable.addShaped("filter_kabel_edit", <item:storagenetwork:filter_kabel> * 4, [
                    [air, <item:storagenetwork:storage_kabel>, air],
                    [<item:storagenetwork:storage_kabel>, <item:rftoolsbase:filter_module>, <item:storagenetwork:storage_kabel>],
                    [air, <item:storagenetwork:storage_kabel>, air]]);
            #export cable
                craftingTable.removeRecipe(<item:storagenetwork:export_kabel>);
                craftingTable.addShaped("export_kabel_edit", <item:storagenetwork:export_kabel> * 4, [
                    [air, <item:storagenetwork:kabel>, air],
                    [<item:storagenetwork:kabel>, <item:minecraft:dispenser>, <item:storagenetwork:kabel>],
                    [air, <item:storagenetwork:kabel>, air]]);
        #network picker
            craftingTable.removeRecipe(<item:storagenetwork:picker_remote>);
            craftingTable.addShaped("picker_remote_edit", <item:storagenetwork:picker_remote>, [
                [<item:immersiveengineering:ingot_hop_graphite>, <item:storagenetwork:import_filter_kabel>, <item:immersiveengineering:ingot_hop_graphite>],
                [<item:storagenetwork:import_filter_kabel>, <item:storagenetwork:inventory_remote>, <item:storagenetwork:import_filter_kabel>],
                [<item:immersiveengineering:ingot_hop_graphite>, <item:storagenetwork:import_filter_kabel>, <item:immersiveengineering:ingot_hop_graphite>]]);
        #network collector
            craftingTable.removeRecipe(<item:storagenetwork:collector_remote>);
            craftingTable.addShaped("collector_remote_edit", <item:storagenetwork:collector_remote>, [
                [<item:mekanism:hdpe_sheet>, <item:storagenetwork:import_kabel>, <item:mekanism:hdpe_sheet>],
                [<item:storagenetwork:import_kabel>, <item:storagenetwork:inventory_remote>, <item:storagenetwork:import_kabel>],
                [<item:mekanism:hdpe_sheet>, <item:storagenetwork:import_kabel>, <item:mekanism:hdpe_sheet>]]);
        #builder remote
            craftingTable.removeRecipe(<item:storagenetwork:builder_remote>);
            craftingTable.addShaped("builder_remote_edit", <item:storagenetwork:builder_remote>, [
                [<item:immersiveengineering:ingot_hop_graphite>, <item:storagenetwork:request>, <item:immersiveengineering:ingot_hop_graphite>],
                [<item:storagenetwork:request>, <item:storagenetwork:inventory_remote>, <item:storagenetwork:request>],
                [<item:immersiveengineering:ingot_hop_graphite>, <item:storagenetwork:request>, <item:immersiveengineering:ingot_hop_graphite>]]);
#powah
    #items
        #dielectric casing
            craftingTable.removeRecipe(<item:powah:dielectric_casing>);
            craftingTable.addShaped("dielectric_casing_edit", <item:powah:dielectric_casing>, [
                [ironPlate, <item:powah:dielectric_rod_horizontal>, ironPlate],
                [<item:powah:dielectric_rod>, air, <item:powah:dielectric_rod>],
                [ironPlate, <item:powah:dielectric_rod_horizontal>, ironPlate]]);
        #capacitor
            #hardened
                craftingTable.removeRecipe(<item:powah:capacitor_hardened>);
                craftingTable.addShaped("capacitor_hardened_edit", <item:powah:capacitor_hardened>, [
                    [<item:powah:dielectric_paste>, <item:powah:steel_energized>, <item:powah:dielectric_paste>],
                    [<item:powah:steel_energized>, <item:powah:capacitor_basic_large>, <item:powah:steel_energized>],
                    [<item:powah:dielectric_paste>, <item:powah:steel_energized>, <item:powah:dielectric_paste>]]);
            #blazing
                craftingTable.removeRecipe(<item:powah:capacitor_blazing>);
                craftingTable.addShaped("capacitor_blazing_edit", <item:powah:capacitor_blazing>, [
                    [<item:powah:dielectric_paste>, <item:powah:crystal_blazing>, <item:powah:dielectric_paste>],
                    [<item:powah:crystal_blazing>, <item:powah:capacitor_hardened>, <item:powah:crystal_blazing>],
                    [<item:powah:dielectric_paste>, <item:powah:crystal_blazing>, <item:powah:dielectric_paste>]]);
            #niotic
                craftingTable.removeRecipe(<item:powah:capacitor_niotic>);
                craftingTable.addShaped("capacitor_niotic_edit", <item:powah:capacitor_niotic>, [
                    [<item:powah:dielectric_paste>, <item:powah:crystal_niotic>, <item:powah:dielectric_paste>],
                    [<item:powah:crystal_niotic>, <item:powah:capacitor_blazing>, <item:powah:crystal_niotic>],
                    [<item:powah:dielectric_paste>, <item:powah:crystal_niotic>, <item:powah:dielectric_paste>]]);
            #spirited
                craftingTable.removeRecipe(<item:powah:capacitor_spirited>);
                craftingTable.addShaped("capacitor_spirited_edit", <item:powah:capacitor_spirited>, [
                    [<item:powah:dielectric_paste>, <item:powah:crystal_spirited>, <item:powah:dielectric_paste>],
                    [<item:powah:crystal_spirited>, <item:powah:capacitor_niotic>, <item:powah:crystal_spirited>],
                    [<item:powah:dielectric_paste>, <item:powah:crystal_spirited>, <item:powah:dielectric_paste>]]);
            #nitro
                craftingTable.removeRecipe(<item:powah:capacitor_nitro>);
                craftingTable.addShaped("capacitor_nitro_edit", <item:powah:capacitor_nitro>, [
                    [<item:powah:dielectric_paste>, <item:powah:crystal_nitro>, <item:powah:dielectric_paste>],
                    [<item:powah:crystal_nitro>, <item:powah:capacitor_spirited>, <item:powah:crystal_nitro>],
                    [<item:powah:dielectric_paste>, <item:powah:crystal_nitro>, <item:powah:dielectric_paste>]]);
        #reactor
            #basic
                craftingTable.removeRecipe(<item:powah:reactor_basic>);
                craftingTable.addShaped("basic_reactor_edit", <item:powah:reactor_basic>, [
                    [<item:powah:reactor_starter>, <item:kubejs:compressed_obsidian>, <item:powah:reactor_starter>],
                    [<item:powah:capacitor_basic_large>, <item:powah:dielectric_casing>, <item:powah:capacitor_basic_large>],
                    [<item:powah:reactor_starter>, <item:kubejs:compressed_obsidian>, <item:powah:reactor_starter>]]);
            #hardened
                craftingTable.removeRecipe(<item:powah:reactor_hardened>);
                craftingTable.addShaped("hardened_reactor_edit", <item:powah:reactor_hardened>, [
                    [<item:powah:reactor_basic>, <item:kubejs:omega_dust>, <item:powah:reactor_basic>],
                    [<item:powah:capacitor_hardened>, <item:powah:dielectric_casing>, <item:powah:capacitor_hardened>],
                    [<item:powah:reactor_basic>, <item:kubejs:omega_dust>, <item:powah:reactor_basic>]]);
            #blazing
                craftingTable.removeRecipe(<item:powah:reactor_blazing>);
                craftingTable.addShaped("blazing_reactor_edit", <item:powah:reactor_blazing>, [
                    [<item:powah:reactor_hardened>, <item:kubejs:alloy_chaotic>, <item:powah:reactor_hardened>],
                    [<item:powah:capacitor_blazing>, <item:powah:dielectric_casing>, <item:powah:capacitor_blazing>],
                    [<item:powah:reactor_hardened>, <item:kubejs:alloy_chaotic>, <item:powah:reactor_hardened>]]);
            #niotic
                craftingTable.removeRecipe(<item:powah:reactor_niotic>);
                craftingTable.addShaped("niotic_reactor_edit", <item:powah:reactor_niotic>, [
                    [<item:powah:reactor_blazing>, <item:moremekanismprocessing:tungsten_ingot>, <item:powah:reactor_blazing>],
                    [<item:powah:capacitor_niotic>, <item:powah:dielectric_casing>, <item:powah:capacitor_niotic>],
                    [<item:powah:reactor_blazing>, <item:moremekanismprocessing:tungsten_ingot>, <item:powah:reactor_blazing>]]);
            #spirited
                craftingTable.removeRecipe(<item:powah:reactor_spirited>);
                craftingTable.addShaped("spirited_reactor_edit", <item:powah:reactor_spirited>, [
                    [<item:powah:reactor_niotic>, <item:kubejs:chaotic_control_circuit>, <item:powah:reactor_niotic>],
                    [<item:powah:capacitor_spirited>, <item:powah:dielectric_casing>, <item:powah:capacitor_spirited>],
                    [<item:powah:reactor_niotic>, <item:kubejs:chaotic_control_circuit>, <item:powah:reactor_niotic>]]);
            #nitro
                craftingTable.removeRecipe(<item:powah:reactor_nitro>);
                craftingTable.addShaped("nitro_reactor_edit", <item:powah:reactor_nitro>, [
                    [<item:powah:reactor_spirited>, <item:kubejs:reactor_core>, <item:powah:reactor_spirited>],
                    [<item:powah:capacitor_nitro>, <item:powah:dielectric_casing>, <item:powah:capacitor_nitro>],
                    [<item:powah:reactor_spirited>, <item:kubejs:reactor_core>, <item:powah:reactor_spirited>]]);
        #dielectric paste
            craftingTable.removeRecipe(<item:powah:dielectric_paste>);
            craftingTable.addShapeless("dielectric_paste_blaze_edit", <item:powah:dielectric_paste> * 16, [<tag:items:minecraft:coals>, <tag:items:minecraft:coals>, <item:minecraft:clay_ball>, <item:minecraft:blaze_powder>, <item:minecraft:blaze_powder>]);
            craftingTable.addShapeless("dielectric_paste_lava_edit", <item:powah:dielectric_paste> * 16, [<tag:items:minecraft:coals>, <tag:items:minecraft:coals>, <item:minecraft:clay_ball>, <item:minecraft:lava_bucket>]);
#environmental tech
    #jei info
        #crystals
            #litherite
                mods.jei.JEI.addInfo(<item:envirocore:litherite_crystal>, ["Litherite can either be crafted or obtained from the crystal program in the void miner. Available in void miner tiers 1-8."]);
            #erodium
                mods.jei.JEI.addInfo(<item:envirocore:erodium_crystal>, ["Erodium can either be obtained from the crystal program in the void miner. Available in void miner tiers 1-8. Or obtained by compressing Litherite"]);
            #kyronite
                mods.jei.JEI.addInfo(<item:envirocore:kyronite_crystal>, ["Kyronite can either be obtained from the crystal program in the void miner. Available in void miner tiers 2-8. Or obtained by compressing Erodium"]);
            #pladium
                mods.jei.JEI.addInfo(<item:envirocore:pladium_crystal>, ["Pladium can either be obtained from the crystal program in the void miner. Available in void miner tiers 3-8. Or obtained by compressing Kyronite"]);
            #ionite
                mods.jei.JEI.addInfo(<item:envirocore:ionite_crystal>, ["Ionite can either be obtained from the crystal program in the void miner. Available in void miner tiers 4-8. Or obtained by compressing Pladium"]);
            #aethium
                mods.jei.JEI.addInfo(<item:envirocore:aethium_crystal>, ["Aethium can either be obtained from the crystal program in the void miner. Available in void miner tiers 5-8. Or obtained by compressing Ionite"]);
            #nanorite
                mods.jei.JEI.addInfo(<item:envirocore:nanorite_crystal>, ["Nanorite can either be obtained from the crystal program in the void miner. Available in void miner tiers 6-8. Or obtained by compressing Aethium"]);
            #xerothium
                mods.jei.JEI.addInfo(<item:envirocore:xerothium_crystal>, ["Xerothium can either be obtained from the crystal program in the void miner. Available in void miner tiers 7-8. Or obtained by compressing Nanorite"]);
    #items
        #obsidian plate
            craftingTable.removeRecipe(<item:envirocore:obsidian_plate>);
            craftingTable.addShapeless("obsidian_plate_edit", <item:envirocore:obsidian_plate>*8, [<item:kubejs:compressed_obsidian>]);
        #frame
            #litherite
                craftingTable.removeRecipe(<item:envirocore:litherite_frame>);
                craftingTable.addShaped("litherite_frame_edit", <item:envirocore:litherite_frame>, [
                    [<item:minecraft:lapis_block>, <item:envirocore:litherite_interconnect>, <item:minecraft:lapis_block>],
                    [<item:envirocore:litherite_crystal>, <tag:items:envirocore:structure/panels>, <item:envirocore:litherite_crystal>],
                    [<item:minecraft:lapis_block>, <item:minecraft:iron_block>, <item:minecraft:lapis_block>]]);
            #erodium
                craftingTable.removeRecipe(<item:envirocore:erodium_frame>);
                craftingTable.addShaped("erodium_frame_edit", <item:envirocore:erodium_frame>, [
                    [<tag:items:forge:storage_blocks/gold>, <item:envirocore:erodium_interconnect>, <tag:items:forge:storage_blocks/gold>],
                    [<item:envirocore:erodium_crystal>, <item:envirocore:litherite_frame>, <item:envirocore:erodium_crystal>],
                    [<tag:items:forge:storage_blocks/gold>, <item:minecraft:end_crystal>, <tag:items:forge:storage_blocks/gold>]]);
            #kyronite
                craftingTable.removeRecipe(<item:envirocore:kyronite_frame>);
                craftingTable.addShaped("kyronite_frame_edit", <item:envirocore:kyronite_frame>, [
                    [<item:minecraft:diamond_block>, <item:envirocore:kyronite_interconnect>, <item:minecraft:diamond_block>],
                    [<item:envirocore:kyronite_crystal>, <item:envirocore:erodium_frame>, <item:envirocore:kyronite_crystal>],
                    [<item:minecraft:diamond_block>, <item:lifesteal:heart_core>, <item:minecraft:diamond_block>]]);
            #pladium
                craftingTable.removeRecipe(<item:envirocore:pladium_frame>);
                craftingTable.addShaped("pladium_frame_edit", <item:envirocore:pladium_frame>, [
                    [<item:minecraft:netherite_ingot>, <item:envirocore:pladium_interconnect>, <item:minecraft:netherite_ingot>],
                    [<item:envirocore:pladium_crystal>, <item:envirocore:kyronite_frame>, <item:envirocore:pladium_crystal>],
                    [<item:minecraft:netherite_ingot>, <item:tconstruct:queens_slime_ingot>, <item:minecraft:netherite_ingot>]]);
            #ionite
                craftingTable.removeRecipe(<item:envirocore:ionite_frame>);
                craftingTable.addShaped("ionite_frame_edit", <item:envirocore:ionite_frame>, [
                    [<item:moremekanismprocessing:tungsten_ingot>, <item:envirocore:ionite_interconnect>, <item:moremekanismprocessing:tungsten_ingot>],
                    [<item:envirocore:ionite_crystal>, <item:envirocore:pladium_frame>, <item:envirocore:ionite_crystal>],
                    [<item:moremekanismprocessing:tungsten_ingot>, <item:minecraft:nether_star>, <item:moremekanismprocessing:tungsten_ingot>]]);
            #aethium
                craftingTable.removeRecipe(<item:envirocore:aethium_frame>);
                craftingTable.addShaped("aethium_frame_edit", <item:envirocore:aethium_frame>, [
                    [<item:minecraft:netherite_block>, <item:envirocore:aethium_interconnect>, <item:minecraft:netherite_block>],
                    [<item:envirocore:aethium_crystal>, <item:envirocore:ionite_frame>, <item:envirocore:aethium_crystal>],
                    [<item:minecraft:netherite_block>, <item:kubejs:alloy_chaotic>, <item:minecraft:netherite_block>]]);
            #nanorite
                craftingTable.removeRecipe(<item:envirocore:nanorite_frame>);
                craftingTable.addShaped("nanorite_frame_edit", <item:envirocore:nanorite_frame>, [
                    [<item:thermal:lumium_block>, <item:envirocore:nanorite_interconnect>, <item:thermal:lumium_block>],
                    [<item:envirocore:nanorite_crystal>, <item:envirocore:aethium_frame>, <item:envirocore:nanorite_crystal>],
                    [<item:thermal:lumium_block>, <item:kubejs:chaotic_control_circuit>, <item:thermal:lumium_block>]]);
            #xerothium
                craftingTable.removeRecipe(<item:envirocore:xerothium_frame>);
                craftingTable.addShaped("xerothium_frame_edit", <item:envirocore:xerothium_frame>, [
                    [<item:kubejs:omega_block>, <item:envirocore:xerothium_interconnect>, <item:kubejs:omega_block>],
                    [<item:envirocore:xerothium_crystal>, <item:envirocore:nanorite_frame>, <item:envirocore:xerothium_crystal>],
                    [<item:kubejs:omega_block>, <item:kubejs:reactor_core>, <item:kubejs:omega_block>]]);
        #crystals
            #erodium
                <recipetype:create:mechanical_crafting>.addRecipe("erodium_crystal_mechanical", <item:envirocore:erodium_crystal>, [
                    [<item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>],
                    [<item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>],
                    [<item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>],
                    [<item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>],
                    [<item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>],
                    [<item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>],
                    [<item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>],
                    [<item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>],
                    [<item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>],
                    [<item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>, <item:envirocore:litherite_crystal>]
                ]);
            #kyronite
                <recipetype:create:mechanical_crafting>.addRecipe("kyronite_crystal_mechanical", <item:envirocore:kyronite_crystal>, [
                    [<item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>],
                    [<item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>],
                    [<item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>],
                    [<item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>],
                    [<item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>],
                    [<item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>],
                    [<item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>],
                    [<item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>],
                    [<item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>],
                    [<item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>, <item:envirocore:erodium_crystal>]
                ]);
            #pladium
                <recipetype:create:mechanical_crafting>.addRecipe("pladium_crystal_mechanical", <item:envirocore:pladium_crystal>, [
                    [<item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>],
                    [<item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>],
                    [<item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>],
                    [<item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>],
                    [<item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>],
                    [<item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>],
                    [<item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>],
                    [<item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>],
                    [<item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>],
                    [<item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>, <item:envirocore:kyronite_crystal>]
                ]);
            #ionite
                <recipetype:create:mechanical_crafting>.addRecipe("ionite_crystal_mechanical", <item:envirocore:ionite_crystal>, [
                    [<item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>],
                    [<item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>],
                    [<item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>],
                    [<item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>],
                    [<item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>],
                    [<item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>],
                    [<item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>],
                    [<item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>],
                    [<item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>],
                    [<item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>, <item:envirocore:pladium_crystal>]
                ]);
            #aethium
                <recipetype:create:mechanical_crafting>.addRecipe("aethium_crystal_mechanical", <item:envirocore:aethium_crystal>, [
                    [<item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>],
                    [<item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>],
                    [<item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>],
                    [<item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>],
                    [<item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>],
                    [<item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>],
                    [<item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>],
                    [<item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>],
                    [<item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>],
                    [<item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>, <item:envirocore:ionite_crystal>]
                ]);
            #nanorite
                <recipetype:create:mechanical_crafting>.addRecipe("nanorite_crystal_mechanical", <item:envirocore:nanorite_crystal>, [
                    [<item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>],
                    [<item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>],
                    [<item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>],
                    [<item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>],
                    [<item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>],
                    [<item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>],
                    [<item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>],
                    [<item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>],
                    [<item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>],
                    [<item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>, <item:envirocore:aethium_crystal>]
                ]);
            #xerothium
                <recipetype:create:mechanical_crafting>.addRecipe("xerothium_crystal_mechanical", <item:envirocore:xerothium_crystal>, [
                    [<item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>],
                    [<item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>],
                    [<item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>],
                    [<item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>],
                    [<item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>],
                    [<item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>],
                    [<item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>],
                    [<item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>],
                    [<item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>],
                    [<item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>, <item:envirocore:nanorite_crystal>],
                ]);
#

for modifierName in loot.modifiers.getAllNames() {
    print(modifierName);
}
