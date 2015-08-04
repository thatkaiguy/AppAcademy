Pokedex.Models.Pokemon = Backbone.Model.extend({
  urlRoot: '/pokemon',
  toys: function(){
    this._toys = this._toys || new Pokedex.Collections.Toys();
    return this._toys;
  },

  parse: function (payload) {
    if (payload.toys) {
      payload.toys.forEach(function (toy) {
        var newToy = new Pokedex.Models.Toy(toy);
        this.toys().add(newToy);
      }.bind(this));

      delete payload["toys"];
    }
    return payload;
  }
});
