'use strict'


generateCreepName = (prefix)->
  prefix + '_' + Math.random().toString(36).substring(7) #_.size(Game.creeps)



createCreep = (spawn, creep) ->
  memory = {}
  if typeof spawn == 'string'
    spawn = Game.spawns[spawn]
  if typeof creep == 'string'
    memory.role = creep
  else if typeof creep == 'object'
    if !creep.role
      return global.ERR_INVALID_ARGS
    if creep.memory and typeof creep.memory == 'object'
      memory = _.cloneDeep(creep.memory)
    memory.role = creep.role
  else
    return global.ERR_INVALID_ARGS
  #if !(memory.role of roles)
  #  return global.ERR_INVALID_ARGS

  role = require("#{memory.role}")
  body = role.build(spawn, memory)
  name = generateCreepName(memory.role)
  result = spawn.canCreateCreep(body, name)
  if result == global.OK
    result = spawn.createCreep(body, name, memory)
    console.log 'Spawner: Creating ' + name
    if typeof result != 'string'
      console.log 'Unexpected error ' + result + ': cannot spawn ' + name + ' with role ' + memory.role
  result

spawnAttempt = (spawn, queue, priority) ->
  if queue == undefined or queue.length < 1
    return
  # Only go 1 deep if priority matters
  max = if priority then 1 else queue.length
  i = 0
  result = undefined
  while i < max
    result = createCreep(spawn, queue[i])
    if typeof result == 'string'
      queue.splice i, 1
      return true
    switch result
      when global.ERR_INVALID_ARGS
        console.log 'Spawner: Cannot find creep type with parameter' + JSON.stringify(queue[i])
      when global.ERR_NOT_ENOUGH_ENERGY
        break
      else
        console.log 'Spawner: Unknown error ' + result + ' for creep ' + JSON.stringify(queue[i])
    i++
  if i == queue.length or queue.length > 0 and priority
    return false
  return

spawner = (spawn) ->
# Note: when priorityQueue has items and can't spawn, spawning ends immediately
# Spawn specific
  if Memory.spawns[spawn.name]
    if spawnAttempt(spawn, Memory.spawns[spawn.name].spawnPriorityQueue, true) != undefined
      return
    if spawnAttempt(spawn, Memory.spawns[spawn.name].spawnQueue, false)
      return
  else
    newSpawn spawn
  # Global
  if spawnAttempt(spawn, Memory.spawnPriorityQueue, true) != undefined
    return
  if spawnAttempt(spawn, Memory.spawnQueue, false)
    return
  return

initSpawners = ()->
  #FIXME харкод для косячного алгоритма creepAmountSupport

  Game.reinitSpawns()
  for name of Game.spawns
    spawn = Game.spawns[name]
    if !spawn.spawning
      spawner spawn
      spawn.creepAmountSupport()

module.exports =
  createCreep: createCreep
  initSpawners: initSpawners