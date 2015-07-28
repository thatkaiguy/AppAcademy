(function() {
    var Asteroids = window.Asteroids = window.Asteroids || {};

    var MovingObject = Asteroids.MovingObject = function (params) {
      this.pos = params.pos || [0,0];
      this.vel = params.vel || [0,0];
      this.radius = params.radius || 10;
      this.color = params.color || "#000000";
      this.game = params.game;

      console.log("Hello!");
    };

    MovingObject.prototype.draw = function (ctx) {
      ctx.fillStyle = this.color;
      ctx.beginPath();
      ctx.arc(
        this.pos[0],
        this.pos[1],
        this.radius,
        0,
        2 * Math.PI,
        false
      );

      ctx.fill();
    };

    MovingObject.prototype.move = function() {
      this.pos[0] += this.vel[0];
      this.pos[1] += this.vel[1];
      if (this.isWrappable) {
        this.pos = this.game.wrap(this.pos);
      } else if (this.game.isOutOfBounds(this.pos)){
        this.game.remove(this);
      }
    };

    MovingObject.prototype.isCollidedWith = function (otherObject) {
      if (Asteroids.Util.distance(this.pos, otherObject.pos) <
        (this.radius + otherObject.radius)) {
          return true;
      }
      return false;
    };

    MovingObject.prototype.collideWith = function (otherObject) {
    };

    MovingObject.prototype.isWrappable = true;
})();
