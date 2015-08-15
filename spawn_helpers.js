module.exports = function () {
    var createHarvesterCreep = function(name){
        if (typeof(name)==='undefined') {
            var workerSuffix = 1
            name = 'Worker' + workerSuffix;
        }
        var newWorker = this.createCreep( [WORK, CARRY, MOVE], name, {role: 'harvester',group:'default'});
        return newWorker;
    }

    return {
        initProrotypeHelpers: function(){
            Spawn.prototype.createHarvesterCreep = createHarvesterCreep;
        }
    }

}