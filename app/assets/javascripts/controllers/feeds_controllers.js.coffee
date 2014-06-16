App.FeedsController = Ember.ArrayController.extend
  sortProperties: ['title']
  sortAscending: true
  actions:
    delete: (feed)->
      feed.deleteRecord()
      feed.save()

    newFeed: (model)->
      @transitionToRoute 'feeds.new'

    editFeed: (model) ->
      @transitionToRoute 'feeds.edit', model

    selectTags: (model)->
      @transitionToRoute 'feeds.tags', model

    toggleFeed: (feed)->
      if feed.get('selected')
        @transitionToRoute 'articles'
      else
        @transitionToRoute 'articles.byFeed', feed

  resetFeedSelection: ->
    @get('model').forEach (feed)->
      feed.set 'selected', false

App.FeedCommonController = Ember.ObjectController.extend
  tags: (->
    promise = @store.find('tag')
    @appHelper.markAttachedTags promise, @get('model')
    Ember.ArrayProxy.createWithMixins Ember.SortableMixin,
      content: promise
      sortProperties: ['title']
      sortAscending: true
  ).property('model')


App.FeedsEditController = App.FeedCommonController.extend()
App.FeedsTagsController = App.FeedCommonController.extend()
