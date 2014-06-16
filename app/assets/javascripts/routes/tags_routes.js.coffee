App.TagsRoute = App.AuthenticatedRoute.extend
  renderTemplate: ->
    @render 'tags',     into: 'application', outlet: 'tags'
    @render 'articles', into: 'application', controller: 'articles'
    @render 'feeds',    into: 'application', controller: 'feeds', outlet: 'feeds'


App.TagsNewRoute = App.AuthenticatedRoute.extend
  renderTemplate: ->
    @render 'tags/new', into: 'application', outlet: 'dialog'

  actions:
    create: ->
      title = @controller.get('title')
      return if !title.trim()
      tag = @store.createRecord 'tag', title: title
      tag.save().then =>
        @controller.set 'title', ''