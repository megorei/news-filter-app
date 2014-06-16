App.FeedsRoute = App.AuthenticatedRoute.extend
  renderTemplate: ->
    @render 'feeds',    into: 'application', outlet: 'feeds'
    @render 'articles', into: 'application', controller: 'articles'
    @render 'tags',     into: 'application', controller: 'tags',  outlet: 'tags'

  actions:
    toggleTag: (feed, tag)->
      if tag.get('attached')
        @detachTag feed, tag
      else
        @attachTag feed, tag

  attachTag: (feed, tag) ->
    taggedFeed = @store.createRecord 'taggedFeed', tag: tag, feed: feed
    taggedFeed.save().then ->
      tag.set 'attached', true
      tag.get('taggedFeeds').pushObject(taggedFeed)
      feed.get('taggedFeeds').pushObject(taggedFeed)


  detachTag: (feed, tag) ->
    feed.get('taggedFeeds').then (taggedFeeds)->
      taggedFeed = taggedFeeds.findBy('tag', tag)
      taggedFeed.deleteRecord()
      taggedFeed.save().then ->
        tag.set 'attached', false
        tag.get('taggedFeeds').removeObject(taggedFeed)
        feed.get('taggedFeeds').removeObject(taggedFeed)


App.FeedsNewRoute = App.FeedsRoute.extend
  renderTemplate: ->
    @render 'feeds/new', into: 'application', outlet: 'dialog'

  actions:
    create: ->
      title = @controller.get('title')
      url   = @controller.get('url')
      feed = @store.createRecord 'feed',
        title:  title
        url:    url

      $('#feed_new').on 'hidden.bs.modal', =>
        feed.save().then (feed)=>
          @transitionTo 'feeds.tags', feed
          @controller.set 'title', ''
          @controller.set 'url', ''

      $('#feed_new').modal('hide')


App.FeedsEditRoute = App.FeedsRoute.extend
  renderTemplate: ->
    @render 'feeds/edit', into: 'application', outlet: 'dialog'

  actions:
    update: ->
      @controller.get('model').save()


App.FeedsTagsRoute = App.FeedsRoute.extend
  renderTemplate: ->
    @render 'feeds/tags', into: 'application', outlet: 'dialog'