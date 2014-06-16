App.TaggedFeed = DS.Model.extend
  feed: DS.belongsTo('feed')
  tag:  DS.belongsTo('tag')