class AddAdditionalFieldsToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :image_url, :text
    add_column :articles, :entry_id, :text
    add_column :articles, :published_at, :datetime
  end
end
