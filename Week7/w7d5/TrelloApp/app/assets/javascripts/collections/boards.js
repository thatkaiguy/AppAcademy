TrelloApp.Collections.Boards = Backbone.Collection.extend({
  url: '/api/boards',
  model: TrelloApp.Models.Board,

  getOrFetch: function(id) {
    var board = this.get(id);
    if (!board) {
      board = new TrelloApp.Models.Board({id: id});
      this.add(board);
    }

    board.fetch();
    return board;
  }
});
