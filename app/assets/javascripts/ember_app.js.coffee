#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require news_filter_app

# for more details see: http://emberjs.com/guides/application/
window.App = Ember.Application.create
  LOG_TRANSITIONS: true,
  LOG_TRANSITIONS_INTERNAL: true,
  LOG_VIEW_LOOKUPS: true,
  LOG_ACTIVE_GENERATION: true


App.ApplicationSerializer = DS.ActiveModelSerializer.extend()
