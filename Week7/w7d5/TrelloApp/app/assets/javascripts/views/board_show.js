TrelloApp.Views.BoardShow = Backbone.CompositeView.extend({
  initialize: function() {
    this.listenTo(this.model.lists(), 'sync', this.render);
    this.listenTo(this.model.lists(), 'add', this.addListView);
    this.listenTo(this.model.lists(), 'remove', this.removeListView);
    this.model.lists().each(this.addListView.bind(this));
    this.listenTo(this.model, 'sync', this.render);
  },

  template: JST['board_show'],

  clasName: "board-show",

  render: function() {
    this.$el.html(this.template({board: this.model}));
    this.attachSubviews();
    return this;
  },

  addListView: function(list) {
    var listView = new TrelloApp.Views.ListIndexItem({
      model: list
    });
    this.addSubview('.lists', listView);
  },

  removeListView: function(list) {
    this.removeModelSubview('.lists', list)
  },

  addListNew: function() {
    this.addSubview('.new-list', new TrelloApp.Views.ListNew({
      collection: this.model.lists()
    }));
  }
});
