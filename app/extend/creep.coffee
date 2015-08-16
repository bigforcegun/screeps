module.exports = ->


  Creep::isFull = ()->
    @carry.energy == @carryCapacity

  Creep::isEmpty = ()->
    @carry.energy == 0

  Creep::loadPercentage = ()->
    Math.floor(@carry.energy / (@carryCapacity / 100))

  Creep::harvestSourceById = (sId)->
    source = @room.find(global.FIND_SOURCES,
      filter:
        id: sId
    )[0]
    @harvestSource(source)
    return null

  Creep::harvestSource = (source)->
    @moveTo source
    @harvest source
    return null

  Creep::harvestFirstSource = ()->
    sources = @room.find(global.FIND_SOURCES)
    @harvestSource(sources[0])
    return null

  Creep::harvestClosestSource = ()->
    source = @pos.findClosest(global.FIND_SOURCES)
    @harvestSource(source)
    return null

  Creep::harvestAssignedSource = ()->
    @harvestSourceById(@memory.sourceId)
    return null

  Creep::setStage = (stage)->
    if stage != @memory.stage
      @memory.stage = stage
      @notifyStateChange()

  Creep::getStage = ()->
    @memory.stage

  Creep::notifyStateChange = ()->
    @say(@memory.stage)

  Creep::isEnabled = ()->
    @memory.isEnabled = true unless @memory.isEnabled?
    @memory.isEnabled

  Creep::setEnabled = (flag)->
    if flag
      @say('Turn Off')
    else
      @say('Turn On')
    @memory.isEnabled = flag

  Creep::beforeTurn = ()->
    @deadCheck()

  Creep::deadCheck = () ->
    if (@ticksToLive == 1)
      @dropEnergy()
      return true
    else if (@ticksToLive == 2)
      @say("Bye bye!")
    return false

  Creep::chooseSource = (reset = false)->
    creep = @
    if @memory.sourceId || reset
      return null
    else
      _.forEach(@room.find(global.FIND_SOURCES),
        (source)->
          sourceCreepAmount = source.harvesterLimit()
          creepsForSource = _.filter(Game.creepsByRole(@memory.role)
            (creep)->
              creep.memory.sourceId == source.id
          ,@)
          if _.size(creepsForSource) < sourceCreepAmount
            creep.memory.sourceId = source.id
      ,@)

    return @memory.sourceId

  Creep::saySource = ()->
    @say(@memory.sourceId)

  return @