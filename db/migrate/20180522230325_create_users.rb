class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :name, null: false
      t.text :email, null: false
      t.text :password_digest, null: false
      t.text :codeword, null: false
      t.text :amazon_user_identifier
      t.timestamps
    end
    add_index :users, :email, :unique => true
  end
end
