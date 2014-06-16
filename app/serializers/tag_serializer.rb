class TagSerializer < ActiveModel::Serializer
  attributes :id, :title
  embed :ids
  has_many :tagged_feeds
end
