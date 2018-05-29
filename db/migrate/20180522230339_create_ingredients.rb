class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.references :recipe, null: false
      t.text       :name, null: false
      t.text       :quantity, null: false
      t.integer    :position, null: false
      t.timestamps
    end
  end
end
