NewsReader.Routers.NewsRouter = Backbone.Router.extend({
  routes: {
    "" : "feedsIndex",
    "feeds/new" : "feedNew",
    "feeds/:id" : "feedShow"
  },

  initialize: function($el) {
    this._collection = new NewsReader.Collections.Feeds();
    this.$el = $el;
  },

  feedsIndex: function() {
    var indexView = new NewsReader.Views.FeedsIndex({
      collection: this._collection
    });

    this._collection.fetch();
    this._swap(indexView);
  },

  feedShow: function(id) {
    var showView = new NewsReader.Views.FeedShow({
      model: this._collection.getOrFetch(id)
    });

    this._swap(showView);
  },

  feedNew: function() {
    var newView = new NewsReader.Views.FeedForm({
      collection: this._collection
    });
    this._swap(newView);
  },

  _swap: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$el.html(view.render().$el);
  }
});
