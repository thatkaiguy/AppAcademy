(function() {
  var Asteroids = window.Asteroids = window.Asteroids || {};


  var Game = Asteroids.Game = function(options) {
    this.asteroids = [];
    this.bullets = [];
    this.addAsteroids();
    var initPos = [Game.DIM_X / 2, Game.DIM_Y / 2];
    this.ship = new Asteroids.Ship({pos: initPos, game: this});
  };

  Game.DIM_X = window.innerWidth; //500;
  Game.DIM_Y = window.innerHeight; //500;
  Game.NumAsteroids = 1;

  Game.prototype.addAsteroids = function() {
    for (var i = 0; i < Game.NumAsteroids; i++) {
      this.addObj(new Asteroids.Asteroid({
        pos: this.randomPosition(),
        vel: Asteroids.Util.randomVect(3), //TODO change to random lengths?
        game: this
      }));
    }
  };

  Game.prototype.addObj = function (obj) {
    if (obj instanceof Asteroids.Bullet){
      this.bullets.push(obj);
    } else if (obj instanceof Asteroids.Asteroid){
      this.asteroids.push(obj);
    }
  };

  Game.prototype.randomPosition = function() {
    var posX = Math.floor(Math.random() * (Game.DIM_X + 1));
    var posY = Math.floor(Math.random() * (Game.DIM_Y + 1));

    return [posX, posY];
  };

  Game.prototype.draw = function (ctx) {
    ctx.clearRect(0,0, Game.DIM_X, Game.DIM_Y);

    this.allObjects().forEach(function (object) {
        object.draw(ctx);
    });
  };

  Game.prototype.moveObjects = function () {
    this.allObjects().forEach(function (object) {
      object.move();
    });
  };

  Game.prototype.wrap = function (pos) {
    var xPos = pos[0] % Game.DIM_X;
    var yPos = pos[1] % Game.DIM_Y;

    if (pos[0] <= 0){
      xPos = Game.DIM_X;
    }

    if (pos[1] <= 0){
      yPos = Game.DIM_Y;
    }

    return [xPos, yPos];
  };

  //TODO

  Game.prototype.checkCollisions = function() {
    for (var i = 0; i < this.allObjects().length - 1; i++) {
      for (var j = i + 1; j < this.allObjects().length; j++) {
        if (this.allObjects()[i].isCollidedWith(this.allObjects()[j])) {
          // alert("COLLISION");
          this.allObjects()[i].collideWith(this.allObjects()[j]);
        }
      }
    }
  };

  Game.prototype.step = function() {
    this.moveObjects();
    this.checkCollisions();
  };

  Game.prototype.remove = function (obj) {
    var idx = null;
    if (obj instanceof Asteroids.Bullet){
      idx = this.bullets.indexOf(obj);
      this.bullets.splice(idx, 1);
    } else if (obj instanceof Asteroids.Asteroid){
      idx = this.asteroids.indexOf(obj);
      this.asteroids.splice(idx, 1);
    }
  };


  Game.prototype.allObjects = function() {
    var objects = this.asteroids.concat(this.bullets).concat([this.ship]);
    return objects;
  };

  Game.prototype.isOutOfBounds = function(pos) {
    if (pos[0] > Game.DIM_X ||
        pos[0] < 0 ||
        pos[1] > Game.DIM_Y ||
        pos[1] < 0
      ) {
        return true;
      }
    return false;
  };

})();
