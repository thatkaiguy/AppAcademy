TrelloApp.Views.BoardIndexItem = Backbone.CompositeView.extend({

    template: JST['board_index_item'],

    events: {
      "click .btn.delete" : "deleteBoard"
    },

    tagName: "li",

    render: function() {
      this.$el.html(this.template({board: this.model}));
      return this;
    }
    ,

    deleteBoard: function(e) {
      e.preventDefault()

      var $deleteBtn = $(e.currentTarget);
      this.model.destroy();
    }

});
