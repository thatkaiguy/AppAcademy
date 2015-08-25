TrelloApp.Views.ListIndexItem = Backbone.CompositeView.extend({
    initialize: function() {
      this.listenTo(this.model.cards(), 'add', this.addCardIndexItemView);
      this.listenTo(this.model.cards(), 'remove', this.removeCardView);
      this.model.cards().each(this.addCardIndexItemView.bind(this));
    },

    template: JST['list_index_item'],

    tagName: "li",

    render: function() {
      this.$el.html(this.template({list: this.model}));
      this.attachSubviews();
      return this;
    },

    addCardIndexItemView: function(card) {
      var cardIndexItemView = new TrelloApp.Views.CardIndexItem({
        model: card
      });

      this.addSubview('.cards', cardIndexItemView);
    },

    removeCardView: function(card) {
      this.removeModelSubview('.cards', card);
    }

});
