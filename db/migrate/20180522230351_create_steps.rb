class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.references :recipe, null: false
      t.integer    :position, null: false
      t.text       :description, null: false
      t.timestamps
    end

    add_index :steps, [:recipe_id, :position], :unique => true
  end
end
