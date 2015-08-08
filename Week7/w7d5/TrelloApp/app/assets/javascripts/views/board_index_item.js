TrelloApp.Views.BoardIndexItem = Backbone.CompositeView.extend({

    template: JST['board_index_item'],

    tagName: "li",

    render: function() {
      this.$el.html(this.template({board: this.model}));
      return this;
    },

});
