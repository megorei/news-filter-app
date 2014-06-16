App.Article = DS.Model.extend
  userId:           DS.attr 'string'
  favorite:         DS.attr 'boolean'
  likesCount:       DS.attr 'number'
  title:            DS.attr 'string'
  url:              DS.attr 'string'
  description:      DS.attr 'string'
  publishedAt:      DS.attr 'date'
  entryId:          DS.attr 'string'
  imageUrl:         DS.attr 'string'
  feed:             DS.belongsTo 'feed'
  favoriteArticles: DS.hasMany 'favoriteArticle', key: 'favorite_article_ids', async: true

  isFavorite: (userId, success, fail)->
    @get('favoriteArticles').then (favoriteArticles)->
      favoriteArticle = favoriteArticles.findBy 'userId', userId
      if favoriteArticle && success
        success favoriteArticle
      else if fail
        fail favoriteArticle

  updateLikesCount: (->
    @get('favoriteArticles').then (favoriteArticles)=>
      @set 'likesCount', favoriteArticles.get('length')
  ).observes('favoriteArticles.@each')