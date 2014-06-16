class CreateTaggedFeeds < ActiveRecord::Migration
  def change
    create_table :tagged_feeds, id: :uuid do |t|
      t.uuid :feed_id
      t.uuid :tag_id

      t.timestamps
    end
  end
end
