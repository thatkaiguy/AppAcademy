TrelloApp.Views.BoardNew = Backbone.CompositeView.extend({
  template: JST['board_new'],

  events: {
    "submit" : "saveBoard"
  },

  tagName: "form",

  className: "board-new",

  render: function() {
    this.$el.html(this.template());
    return this;
  },

  saveBoard: function(e) {
    e.preventDefault();

    var $frm = $(e.currentTarget);
    var frmJSON = $frm.serializeJSON();

    var boardModel = new TrelloApp.Models.Board(frmJSON.board);
    var view = this;

    boardModel.save({}, {
      success: function(board) {
        view.collection.add(board);
        view.render();
      },
      error: function() {
        alert("could not save board!")
      }
    })
  }
});
