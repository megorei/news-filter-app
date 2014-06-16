class TaggedFeed < ActiveRecord::Base
  belongs_to :feed
  belongs_to :tag

  validates :feed_id, uniqueness: {scope: :tag_id},   presence: true
  validates :tag_id,  uniqueness: {scope: :feed_id},  presence: true
end
