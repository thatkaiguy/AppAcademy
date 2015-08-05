Pokedex.Views.PokemonDetail = Backbone.View.extend({
  template: JST['pokemon_detail'],
  initialize: function() {
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.model.toys(), 'remove', this.render);
  },

  events: {
    "click .toys li" : "selectToyFromList"
  },

  render: function() {
    this.$el.html(this.template({pokemon: this.model}));

    this.model.toys().forEach(function(toy) {
      this.addToyToList(toy);
    }.bind(this));

    return this;
  },

  addToyToList: function (toy) {
    this.$el.find('.toys').append(JST['toy_list_item']({toy: toy}));
  },

  selectToyFromList: function(e) {
    var $toyLi = $(e.currentTarget);
    var toy = this.model.toys().get($toyLi.data("toy-id"));

    Backbone.history.navigate("pokemon/" + toy.get("pokemon_id") + "/toys/" + toy.get("id"), {trigger: true})
  }
});
