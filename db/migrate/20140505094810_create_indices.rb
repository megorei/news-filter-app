class CreateIndices < ActiveRecord::Migration
  def change
    add_index :articles, :title
    add_index :articles, :entry_id
    add_index :articles, :created_at
    add_index :articles, :published_at

    add_index :favorite_articles, :user_id
    add_index :favorite_articles, :article_id

    add_index :feeds, :title
    add_index :feeds, :user_id

    add_index :tagged_feeds, :feed_id
    add_index :tagged_feeds, :tag_id

    add_index :tags, :title

    add_index :users, :email
    add_index :users, :password_digest
    add_index :users, :api_token
  end
end
