App.AuthManager = Ember.Object.extend
  init: ->
    authToken = $.cookie('auth_token')
    userId    = $.cookie('auth_user')
    if !Ember.isEmpty(authToken) && !Ember.isEmpty(userId)
      @authenticate authToken, userId

  authenticate: (authToken, userId)->
    @set 'session', @store.createRecord 'session',
      authToken: authToken
      userId:    userId
    Ember.$.ajaxSetup
      headers:
        'X-API-TOKEN': authToken

  isAuthenticated: ->
    !Ember.isEmpty(@get('session.authToken')) && !Ember.isEmpty(@get('session.userId'))

  reset: ->
    @set 'session', null

  sessionObserver: (->
    if Ember.isEmpty @get('session')
      $.removeCookie 'auth_token'
      $.removeCookie 'auth_user'
    else
      $.cookie 'auth_token', @get('session.authToken')
      $.cookie 'auth_user',  @get('session.userId')
  ).observes('session')