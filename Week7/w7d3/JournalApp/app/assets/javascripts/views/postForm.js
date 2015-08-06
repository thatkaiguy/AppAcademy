JournalApp.Views.PostForm = Backbone.View.extend({
  template: JST['postForm'],

  events: {
    "submit form" : "savePost"
  },

  render: function () {
    this.$el.html(this.template({
      post: this.model
    }));
    return this;
  },

  savePost: function(e) {
    e.preventDefault();

    var view = this;
    var $frm = $(e.currentTarget);
    var frmJSON = $frm.serializeJSON();

    this.model.save(frmJSON.post, {
      wait: true,
      success: function(model, response, options) {
        view.collection.add(model);
        Backbone.history.navigate("posts/" + model.get("id"), {trigger: true})
      },
      error: function(model, response, options) {
        view.render();
        view.$el.append($("<p>").text(response.responseText))
      }
    });
  }
});
