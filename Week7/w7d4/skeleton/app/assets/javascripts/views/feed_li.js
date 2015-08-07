NewsReader.Views.FeedLi = Backbone.CompositeView.extend({
  events: {
    "click .delete": "deleteItem"
  },
  template: JST['feed_li'],
  tagName: 'li',
  className: 'list-group-item clearfix',
  render: function () {
    this.$el.html(this.template({feed: this.model}));
    return this;
  },
  deleteItem: function() {
    this.model.destroy();
    this.remove();
  }
});
