App.ApplicationView = Ember.View.extend
  templateName: "application"
  appName: "NewsFilterApp"

App.DialogView = Ember.View.extend
  afterRenderEvent: ->
    $('.modal').modal()
    $('.modal').on 'hidden.bs.modal', =>
      window.history.go(-1)

App.TagsNewView   = App.DialogView.extend()
App.FeedsEditView = App.DialogView.extend()
App.FeedsNewView  = App.DialogView.extend()
App.FeedsTagsView = App.DialogView.extend()