require 'rails_helper'

RSpec.describe "recipe update endpoint", :type => :request do
  fixtures :users, :recipes, :ingredients, :steps

  it "redirects to the main page when not signed in" do

    post recipe_index_path, params: {
      name: 'guacamole',
      ingredients: [{name: 'salt', quantity: '1 teaspoon'}],
      steps: ['mix it all together']
    }

    expect(response).to redirect_to root_path
  end

  it "updates a recipe" do
    u = users(:one)
    post signin_path, params: { email: u.email, password: 'secret' }

    r = recipes(:one)
    put recipe_path(id: r.id), params: {
      name: 'Lobster Thermidor',
      ingredients: [{name: 'lobster', quantity: '1'}],
      steps: [{description: 'bake the lobster'}]
    }

    r.reload
    expect(r.name).to eq("Lobster Thermidor")
    expect(r.ingredients.first.name).to eq("lobster")
    expect(r.steps.first.description).to eq("bake the lobster")
  end


end