window.Pokedex = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function () {
    Pokedex.pokemonTypes = pokemonTypes;
    var router = new Pokedex.Routers.Router();
    Backbone.history.start();
  }
};

$(document).ready(function () {
  Pokedex.initialize();
});
