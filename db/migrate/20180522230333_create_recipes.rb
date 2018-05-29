class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.references :user, null: false
      t.text :name, null: false
      t.timestamps
    end

    add_index :recipes, [:user_id, :name], :unique => true
  end
end
