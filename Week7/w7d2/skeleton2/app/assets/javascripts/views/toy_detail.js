Pokedex.Views.ToyDetail = Backbone.View.extend({
  template: JST['toy_detail'],

  events: {
    "change select" : "changeOwner"
  },

  render: function(){
    this.$el.html(this.template({toy: this.model, pokes: this.collection}));

    return this;
  },

  changeOwner: function(e) {
    e.preventDefault();

    var $dropdown = $(e.currentTarget);
    var pokemonID = $dropdown.val();
    var pokemon = this.collection.get(this.model.get('pokemon_id'));

    this.model.set("pokemon_id", pokemonID);
    this.model.save({}, {
      success: function() {
        pokemon.toys().remove(this.model);
        this.remove();
        Backbone.history.navigate("/pokemon/" + pokemon.get("id"), {trigger: true});
      }.bind(this)
    });
  }
});
