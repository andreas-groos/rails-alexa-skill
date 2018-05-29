require 'rails_helper'

RSpec.describe Recipe, type: :model do
  fixtures :users

  it "allows a basic recipe to be created" do
    u = users(:one)

    r = Recipe.create(
      user_id: u.id,
      name: 'chicken soup'
    )

    expect(r.id).to be_truthy
  end
end
