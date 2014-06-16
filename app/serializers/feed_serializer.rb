class FeedSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :title, :url, :user_id
  has_many :articles
  has_many :tagged_feeds
  has_one :user
end
