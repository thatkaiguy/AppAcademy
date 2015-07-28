(function() {
  var Asteroids = window.Asteroids = window.Asteroids || {};

  var Util = Asteroids.Util = {};

  Util.inherits = function (childClass, parentClass) {
    function Surrogate () {}
    Surrogate.prototype = parentClass.prototype;
    childClass.prototype = new Surrogate();
    childClass.prototype.constructor = childClass;
  };

  Util.randomVect = function (length) {
    var x = length * 2 * (Math.random(1) - 0.5);
    var y = length * 2 * (Math.random(1) - 0.5);
    return [x,y];
  };

  Util.distance = function(pos1, pos2){

    return Math.sqrt(
      Math.pow(pos1[1] - pos2[1],2) +
      Math.pow(pos1[0] - pos2[0],2));
  };



})();
