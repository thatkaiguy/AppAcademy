TrelloApp.Views.BoardsIndex = Backbone.CompositeView.extend({
  initialize: function() {
    this.listenTo(this.collection, 'sync', this.render);
    this.listenTo(this.collection, 'add', this.addBoardView);
    this.listenTo(this.collection, 'remove', this.removeBoardView);
    this.collection.each(this.addBoardView.bind(this));
    this.addBoardNew();
  },

  template: JST['boards_index'],

  render: function() {
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addBoardView: function(board) {
    var boardIndexItemView = new TrelloApp.Views.BoardIndexItem({model: board});
    this.addSubview('.boards', boardIndexItemView);
  },

  removeBoardView: function(board) {
    this.removeModelSubview('.boards', board)
  },

  addBoardNew: function() {
    this.addSubview('.new-board', new TrelloApp.Views.BoardNew({
      collection: this.collection
    }));
  }
});
