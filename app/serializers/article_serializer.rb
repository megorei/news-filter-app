class ArticleSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :title, :url, :description, :feed_id, :published_at, :entry_id, :image_url
  has_one :feed
  has_many :favorite_articles
end
