class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds, id: :uuid do |t|
      t.string :title
      t.text :url
      t.uuid :user_id

      t.timestamps
    end
  end
end
