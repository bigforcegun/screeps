module.exports = ()->

  @initExtend = ()->
    require('spawn')()
    require('creep')()
    require('room')()
    require('game')()
    require('structure')()
    require('source')()
    require('energy')()


  @setup = ()->
    require('setup')()

  @initStage = ()->
    @spawner = require('stage_spawners')
    @spawner.initSpawners()
    @creeps = require('stage_creeps')
    @creeps()


  @setGlobal = ->
    Game.c = @

  @initMainLoop = ()->
    ###for name of Game.creeps
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
          creep.attack targets[0]###

  @enableCreep = (name,flag = true)->
    Game.creeps[name].setEnabled(flag)

  @setEnabledByRole = (role,flag = true) ->
    _.forEach(Game.creepsByRole(role),
      (creep)->
        creep.setEnabled(flag)
        return true
    )

  @changeRole = (roleFrom,roleTo) =>
    _.forEach(Game.creepsByRole(roleFrom),
      (creep)->
        creep.memory.role = roleTo
        return true
    )

  @killAll = ()->
    for creep in Game.creeps
      creep.suicide();

  @killAllByRole = (role)->
    for creep in Game.creepsByRole(role)
       creep.suicide()

  return @

