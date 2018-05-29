require 'rails_helper'

RSpec.describe "A user's recipe list", :type => :request do
  fixtures :users, :recipes, :ingredients, :steps

  it "redirects to the main page when not signed in" do
    get recipe_index_path
    expect(response).to redirect_to root_path
  end

  it "responds with a json list of recipes for format js" do
    u = users(:one)
    post signin_path, params: { email: u.email, password: 'secret' }

    get recipe_index_path, xhr: true, params: {format: :json}
    expect(response.status).to eq(200)

    result = JSON.parse response.body
    expect(result['recipes']).to be_truthy
    expect(result['recipes'].length).to be > 0
  end

end