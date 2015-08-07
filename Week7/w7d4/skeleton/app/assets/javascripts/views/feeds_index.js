NewsReader.Views.FeedsIndex = Backbone.CompositeView.extend({
  template: JST["feeds_index"],

  initialize: function() {
    this.listenTo(this.collection, "add", this.addFeedView);
    this.listenTo(this.collection, "sync", this.render);
    this.collection.each(this.addFeedView.bind(this));
    this.listenTo(this.collection, "remove", this.removeFeedView);
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addFeedView: function (feed) {
    var feedView = new NewsReader.Views.FeedLi({
      model: feed
    });
    this.addSubview("ul", feedView);
  },

  removeFeedView: function(feed){
    this.removeModelSubview("ul", feed);
  }
});
