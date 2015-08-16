module.exports = ->

  Source::findClosestHarvester = (opts) ->
    @pos.findClosest global.FIND_MY_CREEPS, filter: memory: role: 'harvester'

  Source::harvesterLimit = () ->
    areaTilesCount = 9
    terrainTiles = []
    tiles = @room.lookAtArea(@pos.y - 1,@pos.x - 1,@pos.y + 1,@pos.x + 1)
    _.forEach(tiles,
      (tileRow)->
        _.forEach(tileRow,
          (tileCol)->
            colTerrainTiles = _.filter(tileCol, {type: 'terrain', terrain:'wall'},'tile')
            terrainTiles = terrainTiles.concat(colTerrainTiles)
        )
    )
    areaTilesCount - _.size(terrainTiles)
