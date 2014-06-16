#= require ./authenticated_route

App.ArticlesRoute = App.AuthenticatedRoute.extend
  renderTemplate: ->
    @render 'articles', into: 'application', controller: 'articles'
    @render 'feeds',    into: 'application', controller: 'feeds', outlet: 'feeds'
    @render 'tags',     into: 'application', controller: 'tags',  outlet: 'tags'


App.ArticlesIndexRoute = App.AuthenticatedRoute.extend
  setupController: ->
    @controllerFor('articles').set 'scope',     null
    @controllerFor('articles').set 'scopeName', 'all'


App.ArticlesByTagRoute = App.AuthenticatedRoute.extend
  setupController: (controller, tag)->
    controller.set 'model', tag
    @controllerFor('articles').set 'scopeName', 'tag'
    tag.get('taggedFeeds').then (taggedFeeds)=>
      @controllerFor('articles').set 'scope', (article)-> taggedFeeds.findBy 'feed', article.get('feed')


App.ArticlesByFeedRoute = App.AuthenticatedRoute.extend
  setupController: (controller, feed)->
    controller.set 'model', feed
    @controllerFor('articles').set 'scopeName', 'feed'
    @controllerFor('articles').set 'scope', (article)-> Ember.isEqual article.get('feed'), feed


App.ArticlesMyRoute = App.AuthenticatedRoute.extend
  setupController: ->
    @controllerFor('articles').set 'scopeName', 'my'
    @controllerFor('articles').set 'scope', (article)=> Ember.isEqual article.get('feed.userId'), @authManager.get('session.userId')


App.ArticlesBestRoute = App.AuthenticatedRoute.extend
  setupController: ->
    @controllerFor('articles').set 'scopeName', 'best'
    @controllerFor('articles').set 'filtered', false