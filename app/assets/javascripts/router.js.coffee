# For more information see: http://emberjs.com/guides/routing/

App.Router.map ()->
  @resource 'feeds', ->
    @route 'new'
    @route 'edit', path: 'edit/:feed_id'
    @route 'tags', path: 'tags/:feed_id'
  @resource 'tags', ->
    @route 'new'
    @route 'edit'
  @resource 'sessions', ->
    @route 'new'
    @route 'delete'
  @resource 'articles', ->
    @route 'my',      path: 'my'
    @route 'best',    path: 'best'
    @route 'byTag',   path: 'by_tag/:tag_id'
    @route 'byFeed',  path: 'by_feed/:feed_id'
