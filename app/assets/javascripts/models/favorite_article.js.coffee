App.FavoriteArticle = DS.Model.extend
  userId:   DS.attr 'string'
  article:  DS.belongsTo 'article'
