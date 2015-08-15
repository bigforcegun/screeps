module.exports = function (globalObj) {

    globalObj.h = {}

    globalObj.h.spawnCreateHarvesterCreep = function(spawnName,name){
        return Game.spawns[spawnName].createHarvesterCreep(name);
    }

    globalObj.h.destroyCreep = function(creepName){
        return Game.creeps[creepName].suicide();
    }


    //aliases
    globalObj.h.schc = globalObj.h.spawnCreateHarvesterCreep;
    globalObj.h.dc = globalObj.h.destroyCreep;
    return globalObj;

}