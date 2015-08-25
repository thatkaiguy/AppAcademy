TrelloApp.Views.CardIndexItem = Backbone.CompositeView.extend({
  template: JST['card_index_item'],

  tagName: "li",

  render: function() {
    var content = this.template({ card: this.model });
    this.$el.html(content);
    return this;
  }
});
