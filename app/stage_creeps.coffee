'use strict'
module.exports = ->
  roles = {}
  for name of Game.creeps
    creep = Game.creeps[name]
    if typeof creep.memory.role != 'string'
      console.log 'Warning: Creep without role at ' + creep.pos.x + ',' + creep.pos.y
      continue
    if creep.spawning == true
      if false #STUB
        roles[creep.memory.role].spawning creep
      continue
    roles[creep.memory.role] = require("#{creep.memory.role}") unless roles[creep.memory.role]?
    creep.beforeTurn()
    roles[creep.memory.role].turn creep if creep.isEnabled()