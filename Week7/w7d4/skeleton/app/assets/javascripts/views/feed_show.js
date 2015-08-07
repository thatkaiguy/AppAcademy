NewsReader.Views.FeedShow = Backbone.CompositeView.extend({
  template: JST["feed_show"],

  events: {
    "click button": "refresh"
  },

  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.entries(), "add", this.addEntryView);
    this.model.entries().each(this.addEntryView.bind(this));
    this.listenTo(this.model.entries(), "remove", this.removeEntryView);
  },


  refresh: function() {
    this.model.fetch();
  },


  render: function () {
    var content = this.template({feed: this.model});
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },

  addEntryView: function (entry) {
    var entryView = new NewsReader.Views.EntryLi({
      model: entry
    });
    this.addSubview("ul", entryView);
  },

  removeEntryView: function(entry){
    this.removeModelSubview("ul", entry);
  }

});
