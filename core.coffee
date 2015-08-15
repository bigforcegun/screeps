module.exports = ()->

  @initHelpers = ()->
    @harvester = require('harvester')
    spawnHelpers = require('spawn_helpers')
    spawnHelpers().initPrototypeHelpers()

  @initConsoleHelper = ()->
    console_helper = require('helper')
    console_helper Game

  @initMainLoop = ()->
    for name of Game.creeps
      creep = Game.creeps[name]
      if creep.memory.role == 'harvester'
        @harvester creep
      if creep.memory.role == 'builder'
        if creep.carry.energy == 0
          creep.moveTo Game.spawns.Spawn1
          Game.spawns.Spawn1.transferEnergy creep
        else
          targets = creep.room.find(global.FIND_CONSTRUCTION_SITES)
          if targets.length
            creep.moveTo targets[0]
            creep.build targets[0]
      if creep.memory.role == 'guard'
        targets = creep.room.find(global.FIND_HOSTILE_CREEPS)
        if targets.length
          creep.moveTo targets[0]
          creep.attack targets[0]

  return @

