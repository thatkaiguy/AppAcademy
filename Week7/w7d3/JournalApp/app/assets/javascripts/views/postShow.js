JournalApp.Views.PostShow = Backbone.View.extend({
  template: JST["postShow"],

  events: {
    "click .post-index-link": "postsIndex",
    "click .show-post-delete": "deletePost",
    "dblclick p": "editPost",
    "blur input": "savePost",
    "blur textarea": "savePost"
  },

  initialize: function() {
    // this.model.fetch({reset: true});
    this.listenTo(this.model, "sync", this.render)
  },

  render: function() {
    this.$el.html(this.template({post: this.model}));
    return this;
  },

  postsIndex: function () {
    Backbone.history.navigate("", {"trigger": true});
  },

  deletePost: function () {
    this.model.destroy();
    this.remove();
    Backbone.history.navigate("", {"trigger": true});
  },

  editPost: function (e) {

    var $c = $(e.currentTarget) // => <p class=""></p>
    $c.empty();
    if ($c.attr("class") === "post-title") {
      $c.append("<input type='text' name='post[title]' value='" + this.model.escape("title") + "'>")
    } else {
      $c.append("<textarea name='post[body]'>" + this.model.escape("body") + "</textarea>");
    }
  },

  savePost: function(e) {
    e.preventDefault();

    var view = this;
    var $frm = $(e.currentTarget);
    var frmJSON = $frm.serializeJSON();

    this.model.save(frmJSON.post, {
      wait: true,
      success: function(model, response, options) {
        // view.collection.add(model);
        Backbone.history.navigate("posts/" + model.get("id"), {trigger: true})
      },
      error: function(model, response, options) {
        view.render();
        view.$el.append($("<p>").text(response.responseText))
      }
    });
  }
});
