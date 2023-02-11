//Maximum Hearts allowed:
val maxHearts = 40 as float;


import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.interact.MCRightClickItemEvent;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.item.ItemStack;
import crafttweaker.api.entity.MCLivingEntity;
import crafttweaker.api.event.entity.player.interact.MCPlayerInteractEvent;
import crafttweaker.api.event.entity.player.MCPlayerEvent;
import crafttweaker.api.server.MCServer;
import crafttweaker.api.item.Rarity;
import crafttweaker.api.world.MCServerWorld;

<item:kubejs:heart_token>.setRarity(Rarity.EPIC);

CTEventManager.register<MCRightClickItemEvent>((event) => {
    val hand = event.getItemStack();
    val player = event.getPlayer();
    val maxHealth = player.getMaxHealth();
    val name = player.getName();
    val world = player.getWorld();
    val curHealth = player.getHealth();
    //Getting Data

    if <item:kubejs:heart_token>.matches(hand) && maxHealth != maxHearts {
        val newHealth = (maxHealth + 2);
        if world is MCServerWorld {world.asServerWorld().server.executeCommand("attribute " + name + " minecraft:generic.max_health base set " + newHealth, true);}
        hand.mutable().shrink(1);
        player.give(<item:kubejs:empty_heart_token>);
    }
    //For extra heart

    if <item:kubejs:empty_heart_token>.matches(hand) && maxHealth != 2 as float {
        val newHealth = (maxHealth - 2);
        if world is MCServerWorld {world.asServerWorld().server.executeCommand("attribute " + name + " minecraft:generic.max_health base set " + newHealth, true);}
        hand.mutable().shrink(1);
        player.give(<item:kubejs:heart_token>);
        if (maxHealth-curHealth) < 2 as float {player.setHealth(newHealth);}
    }
    //For losing a heart

    if <item:kubejs:heart_token>.matches(hand) && maxHealth == maxHearts {
        if world is MCServerWorld {world.asServerWorld().server.executeCommand("msg "+name+" You can't have more than "+maxHearts+ " hp", true);}
    }
    if <item:kubejs:empty_heart_token>.matches(hand) && maxHealth == 2 as float {
        if world is MCServerWorld {world.asServerWorld().server.executeCommand("msg "+name+" You can't have less than 1 heart", true);}
    }
    //If hearts are too low/high
});