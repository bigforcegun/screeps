module.exports = ->
  Spawn::isSpawning = ()->
    !_.isNull(@spawning)

  Spawn::isFull = ()->
    @energy == @energyCapacity

  Spawn::canStoreEnergy = ()->
    !@isFull()

  Spawn::addToQueue = (role)->
    @memory.spawnQueue = [] unless @memory.spawnQueue?
    @memory.spawnQueue.push(role)

  Spawn::addToPriorityQueue = (role)->
    @memory.spawnPriorityQueue = [] unless @memory.spawnPriorityQueue?
    @memory.spawnPriorityQueue.push(role)

  Spawn::getPriorityQueue = ()->
    @memory.spawnPriorityQueue = [] unless @memory.spawnPriorityQueue?
    @memory.spawnPriorityQueue

  Spawn::getQueue = ()->
    @memory.spawnQueue = [] unless @memory.spawnQueue?
    @memory.spawnQueue

  Spawn::clearQueue = ()->
    @memory.spawnQueue = []
    @memory.spawnQueue

  Spawn::clearPriorityQueue = ()->
    @memory.spawnPriorityQueue = []
    @memory.spawnPriorityQueue


  Spawn::clearQueues = ()->
    @clearQueue()
    @clearPriorityQueue()

  Spawn::groupQueue = ()->
    counter = {}
    _.forEach(@getQueue(),
      (role)->
        counter[role] = 0 unless counter[role]?
        counter[role] += 1
    )
    counter

  Spawn::groupPriorityQueue = ()->
    counter = {}
    _.forEach(@getPriorityQueue(),
      (role)->
        counter[role] = 0 unless counter[role]?
        counter[role] += 1
    )
    counter


  Spawn::defaultCreepQueue =
      base_harvester: 5
      #builder1: 1
      cntr_worker1: 3
      carrier1: 2

  Spawn::creepAmountSupport = ()->
    unless @isSpawning()
      _.forEach(@defaultCreepQueue,
        (neededRoleCount, role)->
          inGameRoleCount = _.size(Game.creepsByRole(role))
          inQueueRoleCount = @groupPriorityQueue()[role] || 0
          if neededRoleCount > (inGameRoleCount + inQueueRoleCount)
            neededRoleCount = neededRoleCount - (inGameRoleCount + inQueueRoleCount)
            #console.log('addToQueue',role,neededRoleCount)
            if neededRoleCount > 0
              for i in [1..neededRoleCount]
                @addToPriorityQueue(role)
      ,@)


