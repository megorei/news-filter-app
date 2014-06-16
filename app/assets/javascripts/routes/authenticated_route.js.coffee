App.AuthenticatedRoute = Ember.Route.extend
  beforeModel: ->
    if !@authManager.isAuthenticated()
      @transitionTo 'sessions.new'