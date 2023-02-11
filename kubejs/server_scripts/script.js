// priority: 0

settings.logAddedRecipes = true
settings.logRemovedRecipes = true
settings.logSkippedRecipes = false
settings.logErroringRecipes = true

console.info('Hello, World! (You will see this line every time server resources reload)')

onEvent('recipes', event => {
	// Change recipes here
})

onEvent('item.tags', event => {
	event.get('forge:rods/allmetal').add('kubejs:lead_rod')
	event.get('forge:rods/allmetal').add('kubejs:silver_rod')
	event.get('forge:rods/allmetal').add('kubejs:nickel_rod')
	event.get('forge:rods/allmetal').add('kubejs:electrum_rod')
	event.get('forge:rods/allmetal').add('kubejs:constantan_rod')
	event.get('forge:rods/allmetal').add('kubejs:uranium_rod')
	event.get('forge:ingots').remove('moremekanismprocessing:tungsten_ingot')
	event.get('forge:ingots/tungsten').remove('moremekanismprocessing:tungsten_ingot')
	// Get the #forge:cobblestone tag collection and add Diamond Ore to it
	// event.get('forge:cobblestone').add('minecraft:diamond_ore')

	// Get the #forge:cobblestone tag collection and remove Mossy Cobblestone from it
	// event.get('forge:cobblestone').remove('minecraft:mossy_cobblestone')
})