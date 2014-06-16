App.SessionsNewRoute = Ember.Route.extend
  actions:
    createSession: ->
      email     = @controller.get('email')
      password  = @controller.get('password')
      @controller.set 'email', ''
      @controller.set 'password', ''
      if !Ember.isEmpty(email) && !Ember.isEmpty(password)
        loginData = session:
          email: email
          password: password
        $.post '/v1/sessions', loginData, (data)=>
          @authManager.authenticate(data.session.api_token, data.session.user_id)
          App.__container__.lookup('route:application').setupController()
          @transitionTo 'index'


App.SessionsDeleteRoute = Ember.Route.extend
  beforeModel: ->
    @authManager.reset()
    @transitionTo 'sessions.new'