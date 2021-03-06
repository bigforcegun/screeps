// Generated by CoffeeScript 1.8.0
module.exports = function() {
  Room.prototype.creepsByRole = function(role) {
    return _.filter(this.find(global.FIND_MY_CREEPS), function(creep) {
      return creep.memory.role === role;
    });
  };
  return Room.prototype.hasRole = function(role) {
    return !_.isEmpty(this.creepsByRole(role));
  };
};
