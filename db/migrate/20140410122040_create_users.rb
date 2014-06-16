class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :api_token
      t.string :password_digest
      t.timestamps
    end
  end
end
