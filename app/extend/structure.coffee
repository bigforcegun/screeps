module.exports = ->
  Structure::isFull = ()->
    @energy == @energyCapacity

  Structure::canStoreEnergy = ()->
    !@isFull()
