module.exports = ->
  Room::creepsByRole = (role)->
    _.filter(this.find(global.FIND_MY_CREEPS), (creep)->
      return creep.memory.role == role;
    )

  Room::hasRole = (role)->
    !_.isEmpty(@creepsByRole(role))

