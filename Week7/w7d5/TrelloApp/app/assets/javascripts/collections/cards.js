TrelloApp.Collections.Cards = Backbone.Collection.extend({
  url: '/api/cards',
  model: TrelloApp.Models.Card,

  getOrFetch: function(id) {
    var card = this.get(id);
    if (!card) {
      card = new TrelloApp.Models.Card({id: id});
      this.add(card);
    }

    card.fetch();
    return card;
  }
});
