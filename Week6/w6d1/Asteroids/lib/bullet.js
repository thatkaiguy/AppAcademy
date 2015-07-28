(function() {
  var Asteroids = window.Asteroids = window.Asteroids || {};

  var Bullet = Asteroids.Bullet = function(options) {
    Asteroids.MovingObject.call(this, options);

    this.vel = [options.vel[0] * 3, options.vel[1] * 3];
    // this.pos = options.pos;
    this.color = options.color || Bullet.COLOR;
    this.radius = options.radius || Bullet.RADIUS;

  };

  Asteroids.Util.inherits(Bullet, Asteroids.MovingObject);

  Bullet.RADIUS = 5;
  Bullet.COLOR = "#FFFF00";

  Bullet.prototype.isWrappable = false;

  // Bullet.prototype.collideWith = function(otherObject) {
  //   if (otherObject instanceof Asteroids.Asteroid) {
  //     this.game.remove(otherObject);
  //     this.game.remove(this);
  //   }
  // };

  })();
