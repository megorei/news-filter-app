class Feed < ActiveRecord::Base
  belongs_to :user
  has_many :articles
  has_many :tagged_feeds, dependent: :destroy
  has_many :tags, through: :tagged_feeds

  validates :url, :title, presence: true, uniqueness: true
end
