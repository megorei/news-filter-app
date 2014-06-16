class CreateFavoriteArticles < ActiveRecord::Migration
  def change
    create_table :favorite_articles, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :article_id

      t.timestamps
    end
  end
end
