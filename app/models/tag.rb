class Tag < ActiveRecord::Base
  has_many :tagged_feeds, dependent: :destroy
  has_many :feeds, through: :tagged_feeds

  validates :title, presence: true, uniqueness: true
end
