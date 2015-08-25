TrelloApp.Models.Board = Backbone.Model.extend({
  urlRoot: "/api/boards",

  parse: function(payload) {
    if (payload.lists) {

      payload.lists.forEach(function(listItem) {
        var cardsJSON = [];
        if (listItem.cards) {
            listItem.cards.forEach(function(cardJSON) {
              cardsJSON.push(cardJSON);
            });
            delete listItem.cards;
        }

        var list = new TrelloApp.Models.List(listItem);
        cardsJSON.forEach(function(cardJSON) {
          list.cards().add(cardJSON);
        });
        this.lists().add(list);
      }.bind(this));

      delete payload.lists;
    }

    return payload;
  },

  lists: function() {
    if (!this._list) {
      this._list = new TrelloApp.Collections.Lists();
    }

    return this._list;
  }

});
