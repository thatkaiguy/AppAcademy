TrelloApp.Models.List = Backbone.Model.extend({
  urlRoot: "api/lists",

  cards: function() {
    if (!this._cards) {
      this._cards = new TrelloApp.Collections.Cards();
    }

    return this._cards;
  }
});
