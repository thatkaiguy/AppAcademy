NewsReader.Views.FeedForm = Backbone.CompositeView.extend({
  template: JST["feed_form"],

  events: {
    "submit form": "createFeed"
  },

  render: function() {
    this.$el.html(this.template());
    return this;
  },

  createFeed: function(e) {
    e.preventDefault();
    var frmJSON = $(e.currentTarget).serializeJSON();
    var newFeed = new NewsReader.Models.Feed(frmJSON);

    var view = this;
    newFeed.save({},{
      success: function(model) {
        view.collection.add(model);
        Backbone.history.navigate("feeds/" + model.id, {trigger: true});
      },
      error: function(model, response) {
        view.$(".errors").empty();
        view.$(".errors").append("<li>" + response.responseText + "</li>");
      }
    });
  }
});
