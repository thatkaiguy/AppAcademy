NewsReader.Views.EntryLi = Backbone.CompositeView.extend({
  template: JST["entry_li"],

  tagName: "li",

  render: function() {
    this.$el.html(this.template({ entry: this.model }));
    return this;
  }
});
