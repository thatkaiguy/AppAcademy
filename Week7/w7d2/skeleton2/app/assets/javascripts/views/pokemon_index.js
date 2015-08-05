Pokedex.Views.PokemonIndex = Backbone.View.extend({
  initialize: function() {
    this.collection = new Pokedex.Collections.Pokemon();

    this.listenTo(this.collection, 'sync', this.render);
    this.listenTo(this.collection, 'add', this.addPokemonToList);
  },

  template: JST['pokemon_list_item'],

  events: {
    "click li" : "selectPokemonFromList",
  },

  render: function() {
    this.$el.empty();

    this.collection.forEach(function(pokemon) {
      this.addPokemonToList(pokemon);
    }.bind(this));

    return this;
  },

  addPokemonToList: function(pokemon) {
    this.$el.append(this.template({pokemon: pokemon}));
  },

  refreshPokemon: function(callback) {
    this.collection.fetch({success: callback});
  },

  selectPokemonFromList: function(e) {
    e.preventDefault();

    var $pokeLi = $(e.currentTarget);
    var pokemon = this.collection.get($pokeLi.data("id"));
    Backbone.history.navigate('pokemon/' + pokemon.get('id'), {trigger: true});
  }
});
