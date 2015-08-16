build = (spawn) ->
  [
    global.WORK
    global.WORK
    global.CARRY
    global.MOVE
  ]

initialize = (name) ->

turn = (creep) ->
  if creep.carry.energy == 0
    creep.moveTo Game.spawns.Spawn1
    Game.spawns.Spawn1.transferEnergy creep
  else
    targets = creep.room.find(global.FIND_CONSTRUCTION_SITES)
    if targets.length
      creep.moveTo targets[0]
      creep.build targets[0]

module.exports =
  role: 'builder1'
  group:'builders'
  build: build
  initialize: initialize
  turn: turn

# ---
# generated by js2coffee 2.1.0