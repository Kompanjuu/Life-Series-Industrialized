#priority 1
import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.MCEntityJoinWorldEvent;
import crafttweaker.api.event.entity.MCEntityEvent;
import crafttweaker.api.entity.MCEntity;
import crafttweaker.api.world.MCWorld;
import crafttweaker.api.data.MapData;
/*
CTEventManager.register<MCEntityJoinWorldEvent>((event) => {
    val entity = event.getEntity();
    val dim = entity.getWorld();
    val typ = entity.getType();
    val item = entity.getItem();
    if (dim.dimension != "minecraft:the_end") {
        return;
    }
    if (typ.name != "minecraft:item_frame") {
        return;
    }
    if (item != <item:minecraft:elytra>) {
       return;
    }
    //entity.
});
*/
