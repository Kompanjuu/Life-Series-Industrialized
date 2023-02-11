// priority: 0

console.info('Hello, World! (You will only see this line once in console, during startup)')

onEvent('item.registry', event => {
	event.create('nickel_rod').displayName('Nickel Rod')
	event.create('electrum_rod').displayName('Electrum Rod')
	event.create('silver_rod').displayName('Silver Rod')
	event.create('lead_rod').displayName('Lead Rod')
	event.create('constantan_rod').displayName('Constantan Rod')
	event.create('uranium_rod').displayName('Uranium Rod')
	event.create('omega_ingot').displayName('Omega ingot')
	event.create('omega_dust').displayName('Dissolved Omega Particles')
	event.create('alloy_chaotic').displayName('Chaotic Alloy')
	event.create('chaotic_control_circuit').displayName('Chaotic Control Circuit')
	event.create('reactor_core').displayName('Reactor Core')
	event.create('chaotic_control_circuit_incomplete').displayName('Incomplete Control Circuit')
	event.create('heart_token').displayName('Heart Token')
	event.create('empty_heart_token').displayName('Empty Heart Token')
	// Register new items here
	// event.create('example_item').displayName('Example Item')
})
onEvent('fluid.registry', event => {
	event.create('omega_liquid')
		.thinTexture(0xffffff)
		.displayName('Omega Liquid')
})
onEvent('fluid.registry', event => {
	event.create('terrasteel_liquid')
		.thinTexture(0x000000)
		.displayName('Molten Terrasteel')
})

onEvent('infuse_type.registry', event => {

    event.create("omega").color(4910592)

})

onEvent('block.registry', event => {
	event.create('compressed_andesite').material('stone').hardness(7.0).displayName('Compressed Andesite')
	event.create('omega_block').material('metal').hardness(20.0).displayName('Omega Block')
	event.create('compressed_iron_block').material('metal').hardness(3.0).displayName('Block of Compressed Iron')
	event.create('compressed_obsidian').material('stone').hardness(40.0).displayName('Heavy Compressed Obsidian')
	// Register new blocks here
	// event.create('example_block').material('wood').hardness(1.0).displayName('Example Block')
})