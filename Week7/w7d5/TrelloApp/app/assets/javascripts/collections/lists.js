TrelloApp.Collections.Lists = Backbone.Collection.extend({
  url: '/api/lists',
  model: TrelloApp.Models.List,

  getOrFetch: function(id) {
    var list = this.get(id);
    if (!list) {
      list = new TrelloApp.Models.List({id: id});
      this.add(list);
    }

    list.fetch();
    return list;
  }
});
