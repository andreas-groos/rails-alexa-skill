require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  fixtures :recipes

  it "allows for a basic ingredient to be created" do
    r = recipes(:one)
    i = Ingredient.create(
      recipe_id: r.id,
      name: 'salt',
      quantity: '1 tablespoon',
      position: 5
    )
    expect(i.id).to be_truthy
  end

end
