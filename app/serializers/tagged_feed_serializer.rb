class TaggedFeedSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :feed_id, :tag_id
  has_one :feed
  has_one :tag
end
