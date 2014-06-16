App.ApplicationRoute = Ember.Route.extend
  setupController: ->
    if @authManager.isAuthenticated()
      @controllerFor('tags').set  'model', @store.find('tag')
      @controllerFor('feeds').set 'model', @store.find('feed')

  actions:
    logout: ->
      @transitionTo 'sessions.delete'