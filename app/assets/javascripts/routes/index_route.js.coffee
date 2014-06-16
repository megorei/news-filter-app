App.IndexRoute = App.AuthenticatedRoute.extend
  redirect: ->
    @transitionTo 'articles.best'