(function() {
  var Asteroids = window.Asteroids = window.Asteroids || {};

  var Ship = Asteroids.Ship = function(options) {
    Asteroids.MovingObject.call(this, options);
    this.color = options.color || Ship.COLOR;
    this.radius = options.radius || Ship.RADIUS;
    this.vel = options.vel || [0,0];
  };

  Asteroids.Util.inherits(Ship, Asteroids.MovingObject);

  Ship.COLOR = "#FF4242";
  Ship.RADIUS = 15;
  // Ship.VEL = [0,0];

  Ship.prototype.relocate = function () {
    this.pos = [ Asteroids.Game.DIM_X / 2, Asteroids.Game.DIM_Y / 2 ];
    this.vel = [0,0];
  };

  Ship.prototype.power = function (impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  };

  Ship.prototype.fireBullet = function () {
    this.game.addObj(new Asteroids.Bullet({
      vel: this.vel,
      game: this.game,
      pos: this.pos }));
  };

  })();
