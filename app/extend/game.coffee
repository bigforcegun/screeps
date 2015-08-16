module.exports = ->
  Game.creepsByRole = (role)->
    _.filter(@creeps, (creep)->
      return creep.memory.role == role;
    )

  Game.reinitSpawns = ()->
    _.forEach(@spawns,
      (spawn)->
          spawn.clearQueues()
    @)
