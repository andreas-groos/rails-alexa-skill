require 'rails_helper'

RSpec.describe "recipe destroy endpoint", :type => :request do
  fixtures :users, :recipes, :ingredients, :steps

  it "redirects to the main page when not signed in" do

    post recipe_index_path, params: {
      name: 'guacamole',
      ingredients: [{name: 'salt', quantity: '1 teaspoon'}],
      steps: ['mix it all together']
    }

    expect(response).to redirect_to root_path
  end

  it "deletes a recipe, and its ingredients and steps go away too" do
    u = users(:one)
    post signin_path, params: { email: u.email, password: 'secret' }

    r = recipes(:one)

    expect {
      delete recipe_path(:id => r.id)
    }.to change{ Recipe.count }.by(-1)
    
    expect(response.status).to eq(200)
    expect(Ingredient.where(:recipe_id => r.id).count).to eq(0)
    expect(Step.where(:recipe_id => r.id).count).to eq(0)
  end


end