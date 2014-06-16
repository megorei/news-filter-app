class FavoriteArticleSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :user_id, :article_id
  has_one :user
  has_one :article
end