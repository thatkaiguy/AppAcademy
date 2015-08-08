TrelloApp.Views.BoardShow = Backbone.CompositeView.extend({
  initialize: function() {
    this.listenTo(this.listCollection, 'sync', this.render);
    this.listenTo(this.listCollection, 'add', this.addListView);
    this.listenTo(this.listCollection, 'remove', this.removeListView);
    this.listCollection.each(this.addListView.bind(this));
  },

  template: JST['board_show'],

  clasName: "board-show",

  render: function() {
    this.$el.html(this.template({board: this.model}));
    return this;
  },

  addListView: function(listItem) {
    var listView = new TrelloApp.Views.ListIndex({
      collection: this.listCollection
    });
    this.addSubview('.list', listView);
  },

  removeListView: function(list) {
    this.removeModelSubview('.list', list)
  }
});
