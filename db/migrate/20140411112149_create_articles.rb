class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles, id: :uuid do |t|
      t.text :title
      t.text :url
      t.text :description
      t.uuid :feed_id

      t.timestamps
    end
  end
end
