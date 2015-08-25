TrelloApp.Collections.Boards = Backbone.Collection.extend({
  url: '/api/boards',
  model: TrelloApp.Models.Board,

  getOrFetch: function(id) {
    var board = this.get(id);
    if (!board) {
      board = new TrelloApp.Models.Board({id: id});
      this.add(board);
      var collection = this;
      board.fetch({
        errors: function(model) {
          collection.remove(model);
        }
      });
    } else {
      board.fetch();
    }

    return board;
  }
});
