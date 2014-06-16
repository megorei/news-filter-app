#= require jquery
#= require jquery_ujs
#= require jquery.cookie
#= require bootstrap
#= require ember_app
#= require app_helper
#= require auth_manager

#http://mavilein.github.io/javascript/2013/08/01/Ember-JS-After-Render-Event/
Ember.View.reopen
  didInsertElement: ->
    @_super()
    Ember.run.scheduleOnce('afterRender', this, @afterRenderEvent)
  afterRenderEvent: ->

Ember.Application.initializer
  name: 'authentication'
  initialize: (container, application)->
    application.register('authManager:main', App.AuthManager);
    application.register('appHelper:main',   App.AppHelper);
    application.inject('authManager', 'store', 'store:main');
    application.inject('appHelper',   'store', 'store:main');
    application.inject('route',       'authManager', 'authManager:main');
    application.inject('controller',  'authManager', 'authManager:main');
    application.inject('controller',  'appHelper',   'appHelper:main');
