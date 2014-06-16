App.Tag = DS.Model.extend
  attached:     DS.attr 'boolean'
  title:        DS.attr 'string'
  taggedFeeds:  DS.hasMany('taggedFeed', key: 'tagged_feed_ids', async: true)

  isAttached: (feed, success, fail)->
    @get('taggedFeeds').then (taggedFeeds)->
      taggedFeed = taggedFeeds.findBy('feed', feed)
      if taggedFeed && success
        success taggedFeed
      else if fail
        fail taggedFeed