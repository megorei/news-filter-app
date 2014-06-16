class Article < ActiveRecord::Base
  belongs_to :feed
  has_many :favorite_articles, dependent: :destroy
  has_many :users, through: :favorite_articles

  validates :title,     presence: true
  validates :url,       presence: true, uniqueness: true
  validates :entry_id,  presence: true, uniqueness: true
end
