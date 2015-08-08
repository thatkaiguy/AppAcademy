window.TrelloApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    //debugger
    // alert('Hello from Backbone!');
    new TrelloApp.Routers.TrelloRouter($('.trello-app'));
    Backbone.history.start();
  }
};

$(document).ready(function(){
  TrelloApp.initialize();
});
