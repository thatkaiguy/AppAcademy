JournalApp.Views.PostsIndex = Backbone.View.extend({
  tagName: "ul",

  initialize: function () {
    this.collection.fetch({ reset: true });
    this.listenTo(this.collection, "remove", this.render);
    this.listenTo(this.collection, "reset", this.render);
    this.listenTo(this.collection, "add", this.render);
    this.listenTo(this.collection, "change", this.render);
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function () {
    this.$el.empty();
    this.collection.each( function (post) {
      var postView = new JournalApp.Views.PostIndexItem({ model: post });
      this.$el.append(postView.render().$el);
    }.bind(this));
    this.$el.append($("<a href='#/posts/new'>Add Post</a>"));

    return this;
  }
});
