TrelloApp.Routers.TrelloRouter = Backbone.Router.extend({
  routes: {
    '' : "boardsIndex",
    'boards/:id' : "boardShow"
  },

  initialize: function($el) {
    this._boards = new TrelloApp.Collections.Boards();
    this.$el = $el;
  },

  boardsIndex: function() {
    var indexView = new TrelloApp.Views.BoardsIndex({
      collection: this._boards
    });

    this._boards.fetch();
    this._swap(indexView);
  },

  boardShow: function(id) {
    var board = this._boards.getOrFetch(id);
    var showView = new TrelloApp.Views.BoardShow({
      model: board
    });
    
    this._swap(showView);
  },

  _swap: function(view) {
    this._view && this._view.remove();
    this._view = view;
    this.$el.html(this._view.render().$el);
  }
});
