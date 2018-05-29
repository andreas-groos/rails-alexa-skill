require 'rails_helper'

RSpec.describe "recipe creation endpoint", :type => :request do

  it "redirects to the main page when not signed in" do

    post recipe_index_path, params: {
      name: 'guacamole',
      ingredients: [{name: 'salt', quantity: '1 teaspoon'}],
      steps: ['mix it all together']
    }

    expect(response).to redirect_to root_path
  end

  it "allows a user to create a new recipe" do

    user = User.create!(
      :name => 'monica', :email => "monica@friends.com", :password => "secret", :password_confirmation => "secret"
    )
    post signin_path, params: { email: user.email, password: 'secret' }

    expect {
      post recipe_index_path, params: {
        name: 'guacamole',
        ingredients: [
          {name: 'salt', quantity: '1 teaspoon'},
          {name: 'avocado', quantity: 'one'},
          {name: 'lime', quantity: '1 quarter'}
        ],
        steps: [
          {description: 'mix it all together'},
          {description: 'mash with a fork'}
        ]
      }
    }.to change{ Recipe.count }.by(1)
     .and change { Ingredient.count }.by(3)
     .and change { Step.count }.by(2)

    expect(response.status).to eq(200)
    result = JSON.parse response.body
    expect(result['name']).to eq('guacamole')
  end

  it "does not allow a recipe without a name" do
    user = User.create!(
      :name => 'monica', :email => "monica@friends.com", :password => "secret", :password_confirmation => "secret"
    )
    post signin_path, params: { email: user.email, password: 'secret' }

    expect {
      post recipe_index_path, params: {
        name: '',
        ingredients: [{name: 'salt', quantity: '1 teaspoon'}],
        steps: [{description: 'mix it all together'}]
      }
    }.to change{ Recipe.count }.by(0)

    expect(response.status).to eq(200)
    result = JSON.parse response.body
    expect(result['error']).to be_truthy
    expect(result['error']).to include("can't be blank")
  end

  it "does not allow a user to have two recipes with the same name" do
    user = User.create!(
      :name => 'monica', :email => "monica@friends.com", :password => "secret", :password_confirmation => "secret"
    )
    post signin_path, params: { email: user.email, password: 'secret' }

    expect {
      post recipe_index_path, params: {
        name: 'recipe',
        ingredients: [{name: 'salt', quantity: '1 teaspoon'}],
        steps: [{description: 'mix it all together'}]
      }
    }.to change{ Recipe.count }.by(1)

    expect {
      post recipe_index_path, params: {
        name: 'recipe',
        ingredients: [{name: 'salt', quantity: '1 teaspoon'}],
        steps: [{description: 'mix it all together'}]
      }
    }.to change{ Recipe.count }.by(0)

    expect(response.status).to eq(200)
    result = JSON.parse response.body
    expect(result['error']).to be_truthy
    expect(result['error']).to include("already been taken")
  end

  it "does not allow a recipe without any steps" do
    user = User.create!(
      :name => 'monica', :email => "monica@friends.com", :password => "secret", :password_confirmation => "secret"
    )
    post signin_path, params: { email: user.email, password: 'secret' }

    expect {
      post recipe_index_path, params: {
        name: 'recipe',
        ingredients: [{name: 'salt', quantity: '1 teaspoon'}],
        steps: []
      }
    }.to change{ Recipe.count }.by(0)
    expect(response.status).to eq(200)
    result = JSON.parse response.body
    expect(result['error']).to be_truthy
    expect(result['error']).to include("at least one step")
  end

  it "does not allow a recipe without any ingredients" do
    user = User.create!(
      :name => 'monica', :email => "monica@friends.com", :password => "secret", :password_confirmation => "secret"
    )
    post signin_path, params: { email: user.email, password: 'secret' }

    expect {
      post recipe_index_path, params: {
        name: 'recipe',
        ingredients: [],
        steps: [{description: 'mix it all together'}]
      }
    }.to change{ Recipe.count }.by(0)
    expect(response.status).to eq(200)
    result = JSON.parse response.body
    expect(result['error']).to be_truthy
    expect(result['error']).to include("at least one ingredient")
  end

end
