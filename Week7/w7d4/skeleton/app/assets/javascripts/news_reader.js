window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    // alert('Hello from Backbone!');
    new NewsReader.Routers.NewsRouter($("#content"));
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
