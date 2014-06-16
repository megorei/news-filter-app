App.Feed = DS.Model.extend
  userId:       DS.attr 'string'
  selected:     DS.attr 'boolean'
  title:        DS.attr 'string'
  url:          DS.attr 'string'
  articles:     DS.hasMany 'article'
  taggedFeeds:  DS.hasMany 'taggedFeed', key: 'tagged_feed_ids', async: true