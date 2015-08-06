window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var router = new JournalApp.Routers.PostsRouter($('.journal-app'));
    Backbone.history.start();
  }
};

$(document).ready(function(){
  JournalApp.initialize();
});
