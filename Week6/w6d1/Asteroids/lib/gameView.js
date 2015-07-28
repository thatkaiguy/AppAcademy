(function() {
    var Asteroids = window.Asteroids = window.Asteroids || {};

    var GameView = Asteroids.GameView = function(game, ctx) {
      this.game = game;
      this.ctx = ctx.getContext("2d");
    };

    GameView.prototype.start = function () {
      var game = this.game;
      var ctx = this.ctx;
      this.bindKeyHandlers();
      var interval = window.setInterval(function(){
        game.step();
        game.draw(ctx);
      }, 20);
    };

    GameView.prototype.bindKeyHandlers = function() {
      var game = this.game;
      key('w', function() {game.ship.power([0,-1])} );
      key('a', function() {game.ship.power([-1,0])} );
      key('s', function() {game.ship.power([0,1])} );
      key('d', function() {game.ship.power([1,0])} );
      key('space', function() {game.ship.fireBullet()});
    };

    })();
