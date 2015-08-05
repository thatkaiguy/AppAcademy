Pokedex.Routers.Router = Backbone.Router.extend({
  routes: {
    "" : "pokemonIndex",
    "pokemon/:id" : "pokemonDetail",
    "pokemon/:pokemonId/toys/:toyId" : "toyDetail"
  },

  pokemonIndex: function(callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex.refreshPokemon(callback);
    $("#pokedex .pokemon-list").html(this._pokemonIndex.render().$el);
    this.pokemonForm();
  },

  pokemonDetail: function(id, callback) {
    if (this._toyDetailView) {
      this._toyDetailView.remove();
    }
    if (!this._pokemonIndex) {
      this.pokemonIndex(this.pokemonDetail.bind(this, id, callback));
      return;
    }

    var pokemon = this._pokemonIndex.collection.get(id);

    this._pokemonDetail = new Pokedex.Views.PokemonDetail({model: pokemon});

    $("#pokedex .pokemon-detail").html(this._pokemonDetail.render().$el);

    pokemon.fetch({success: callback});
  },

  toyDetail: function(pokemonId, toyId) {
    if (!this._pokemonDetail){
      this.pokemonDetail(pokemonId, this.toyDetail.bind(this, pokemonId, toyId));
      return;
    }
    var toy = this._pokemonDetail.model.toys().get(toyId);
    var toyDetailView = new Pokedex.Views.ToyDetail({model: toy, collection: this._pokemonIndex.collection});
    $("#pokedex .toy-detail").html(toyDetailView.render().$el);

    this._toyDetailView = toyDetailView;
  },

  pokemonForm: function() {
    var pokemonFormView = new Pokedex.Views.PokemonForm({
      model: new Pokedex.Models.Pokemon(),
      collection: this._pokemonIndex.collection
    });

    $('#pokedex .pokemon-form').html(pokemonFormView.render().$el);
  }
});
