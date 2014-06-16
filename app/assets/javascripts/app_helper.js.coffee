App.AppHelper = Ember.Object.extend
  markAttachedTags: (promise, feed)->
    promise.then (tags)->
      tags.forEach (tag)->
        tag.isAttached feed, (-> tag.set 'attached', true), (-> tag.set 'attached', false)

  markFavoriteArticles: (promise, userId)->
    promise.then (articles)=>
      articles.forEach (article)=>
        article.isFavorite userId, (-> article.set 'favorite',  true), (-> article.set 'favorite', false)

Ember.Handlebars.registerBoundHelper 'formattedDate', (date)->
  if moment(date).isValid() then moment(date).format('LL') else ''