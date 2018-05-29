require 'rails_helper'

RSpec.describe Step, type: :model do
  fixtures :recipes

  it "allows a basic step to be created" do
    r = recipes(:one)

    s = Step.create(
      recipe_id: r.id,
      position: 5,
      description: 'mix it together'
    )

    expect(s.id).to be_truthy
  end
end
