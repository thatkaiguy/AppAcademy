(function() {
  var Asteroids = window.Asteroids = window.Asteroids || {};


  var Asteroid = Asteroids.Asteroid = function (options) {
    Asteroids.MovingObject.call(this, options);

    this.color = options.color || Asteroid.COLOR;
    this.radius = options.radius || Asteroid.RADIUS;
    this.vel = options.vel; //TODO random vel;

  };

  Asteroid.COLOR = "#000000";
  Asteroid.RADIUS = 50;

  Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject);

  Asteroid.prototype.collideWith = function(otherObject) {
    if (otherObject instanceof Asteroids.Ship) {
      otherObject.relocate();
    }

    if (otherObject instanceof Asteroids.Bullet) {
      this.game.remove(otherObject);
      this.game.remove(this);
    }
  };


})();
