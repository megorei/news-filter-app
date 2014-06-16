App.ArticlesController = Ember.ArrayController.extend Ember.MultiSortableMixin,
  needs: ['feeds', 'tags']

  currentUserId: Ember.computed.oneWay('authManager.session.userId')

  arrangedContent: (->
    promise = @store.find('article')

    if @get('currentUserId')
      @appHelper.markFavoriteArticles promise, @get('currentUserId')

    if @get('scope')
      promise.then (articles)=>
        @get('arrangedContent').set 'content', articles.filter(@get('scope'))

    Ember.ArrayProxy.createWithMixins Ember.SortableMixin,
      content: promise
      sortProperties: ['favorite', 'likesCount', 'publishedAt'],
      sortAscending: false
  ).property('currentUserId', 'scope')

  actions:
    toggleFavorite: (article)->
      if article.get('favorite')
        @unmarkAsFavorite article
      else
        @markAsFavorite article

    changeScope: (scope)->
      switch scope
        when 'all'  then @transitionToRoute('articles')
        when 'my'   then @transitionToRoute('articles.my')
        when 'best' then @transitionToRoute('articles.best')

  markAsFavorite: (article)->
    favoriteArticle = @store.createRecord 'favoriteArticle', article: article
    favoriteArticle.save().then ->
      article.set 'favorite', true
      article.get('favoriteArticles').pushObject(favoriteArticle)

  unmarkAsFavorite: (article)->
    controller = @
    article.isFavorite controller.get('currentUserId'), (favoriteArticle)->
      favoriteArticle.deleteRecord()
      favoriteArticle.save().then ->
        article.set 'favorite', false
        article.get('favoriteArticles').removeObject(favoriteArticle)
        controller.set 'filtered', false

  scopeAll: (->
    ['all', 'feed', 'tag'].contains @get('scopeName')
  ).property('scopeName')

  scopeMy: (->
    @get('scopeName') == 'my'
  ).property('scopeName')

  scopeBest: (->
    @get('scopeName') == 'best'
  ).property('scopeName')

  tagsSelection: (->
    if ['all', 'my', 'best', 'feed'].contains(@get('scopeName'))
      @get('controllers.tags').resetTagSelection()
  ).observes('scopeName')

  feedsSelection: (->
    if ['all', 'my', 'best', 'tag'].contains(@get('scopeName'))
      @get('controllers.feeds').resetFeedSelection()
  ).observes('scopeName')

  tagSelection: (->
    if @get('scopeName') == 'tag'
      @get('controllers.tags').resetTagSelection()
      @controllerFor('articles.byTag').get('model').set 'selected', true
  ).observes('scope')

  feedSelection: (->
    if @get('scopeName') == 'feed'
      @get('controllers.feeds').resetFeedSelection()
      @controllerFor('articles.byFeed').get('model').set 'selected', true
  ).observes('scope')

  allLikesSet: (->
    if @get('scopeName') == 'best' && @get('filtered') != true
      likesSet = @get('arrangedContent').every (article)->
        !Ember.isEmpty(article.get('likesCount'))
      if !Ember.isEmpty(@get('arrangedContent')) && likesSet
        @set 'filtered', true
        @set 'scope', (article)=> article.get('likesCount') > 0
  ).observes('filtered', 'arrangedContent.@each.likesCount')