Pokedex.Views.PokemonForm = Backbone.View.extend({
  template: JST['pokemon_form'],

  events: {
    "submit form" : "savePokemon"
  },

  render: function() {
    this.$el.html(this.template({pokemon: this.model}));

    return this;
  },

  savePokemon: function(e) {
    e.preventDefault();

    var $frm = $(e.currentTarget);
    var frmJSON = $frm.serializeJSON();

    this.model.save(frmJSON.pokemon, {
      success: function(model) {
        this.collection.add(model);
        Backbone.history.navigate("pokemon/" + model.get("id"), {trigger : true});
        this.model = new Pokedex.Models.Pokemon();
        this.render();
      }.bind(this)
    })
  }
});
