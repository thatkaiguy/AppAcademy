Pokedex.Views.Pokemon = Backbone.View.extend({
  initialize: function () {
    this.$pokeList = this.$el.find('.pokemon-list');
    this.$pokeDetail = this.$el.find('.pokemon-detail');
    this.$newPoke = this.$el.find('.new-pokemon');
    this.$toyDetail = this.$el.find('.toy-detail');

    this.pokemon = new Pokedex.Collections.Pokemon();
    this.$pokeList.on('click', "li.poke-list-item", this.selectPokemonFromList.bind(this));
    this.$el.find('.new-pokemon').on('submit', this.submitPokemonForm.bind(this));
    this.$pokeDetail.on("click", ".toy-list-item", this.selectToyFromList.bind(this));
  },

  addPokemonToList: function (pokemon) {
    var $li = $("<li>");
    // debugger
    $li.text("Name: " + pokemon.get("name") + " Type: " + pokemon.get("poke_type"));
    $li.addClass("poke-list-item");
    $li.data("id", pokemon.id);
    this.$pokeList.append($li);
  },

  refreshPokemon: function () {
    // var that = this.pokemon;
    this.pokemon.fetch({
      success: function() {
        this.pokemon.models.forEach(function(el) {
          this.addPokemonToList(el);
        }.bind(this));
      }.bind(this)
    });
  },

  renderPokemonDetail: function(pokemon) {
    var $div = $("<div>").addClass("detail");
    $div.append($("<img>"));
    $div.find("img").attr("src", pokemon.get("image_url"));
    for (var key in pokemon.attributes){
      if (key !== 'image_url'){
        var $p = $("<p>").html(key + ": " + pokemon.attributes[key]);
        $div.append($p);
      }
    }

    var $ulToys = $("<ul>").addClass("toys");
    pokemon.fetch({
      success: function(pokemon) {
        pokemon.toys().models.forEach(function(toy) {
          this.addToyToList(toy);
        }.bind(this));
      }.bind(this)
    });
    this.$pokeDetail.html($div);
    this.$pokeDetail.append($ulToys);
  },

  addToyToList: function(toy) {
    var $li = $("<li>");
    $li.addClass("toy-list-item");
    $li.html("Name: " + toy.get("name") + " Hapiness: " + toy.get("happiness") + " Price: " + toy.get("price"));
    $li.data("id", toy.get("id"));
    $li.data("pokemon-id", toy.get("pokemon_id"));
    // debugger
    this.$pokeDetail.find("ul.toys").append($li);
  },

  selectPokemonFromList: function(event) {
    event.preventDefault();
    var $event = $(event.currentTarget);
    var id = $event.data("id");
    var pokemon = this.pokemon.get(id);
    this.renderPokemonDetail(pokemon);
  },

  createPokemon: function (attributes, callback) {
    var newPokemon = new Pokedex.Models.Pokemon(attributes);

    newPokemon.save({}, {
      success: function () {
        this.pokemon.add(newPokemon);
        this.addPokemonToList(newPokemon);
        callback(newPokemon);
      }.bind(this)
    });
  },

  submitPokemonForm: function(event) {
    event.preventDefault();
    var frmJSON = $(event.currentTarget).serializeJSON();
    this.createPokemon(frmJSON.pokemon, this.renderPokemonDetail.bind(this));
  },

  renderToyDetail: function(toy) {
    var $tDetail = $("<div>").addClass("detail");
    $tDetail.append($("<img>").attr("src", toy.get("image_url")))
    for (var key in toy.attributes){
      if (key !== "image_url"){
        var $p = $("<p>").html(key + ": " + toy.attributes[key]);
        $tDetail.append($p);
      }
    }

    this.$toyDetail.append($tDetail);
  },

  selectToyFromList: function(event) {
    var $toyListItem = $(event.currentTarget);
    var p_id = $toyListItem.data("pokemon-id");
    var id = $toyListItem.data("id");
    var pokemon = this.pokemon.get(p_id);
    var toy = pokemon.toys().get(id);
    this.renderToyDetail(toy);
  }
});
