JournalApp.Views.PostIndexItem = Backbone.View.extend({
  template: JST["postIndexItem"],

  tagName: "li",

  events: {
    "click .post-delete": "deletePost",
    "click .post-edit": "editPost"
  },

  render: function() {
    this.$el.html(this.template({post: this.model}));
    return this;
  },

  deletePost: function () {
    this.model.destroy();
    this.remove();
  },

  editPost: function () {
    Backbone.history.navigate( "posts/" + this.model.id + "/edit", { trigger: true } );
  }

});
