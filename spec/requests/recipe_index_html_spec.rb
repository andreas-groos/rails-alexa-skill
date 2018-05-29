require 'rails_helper'

RSpec.describe "A user's recipe list", :type => :request do
  fixtures :users

  it "redirects to the main page when not signed in" do
    get recipe_index_path
    expect(response).to redirect_to root_path
  end

  it "renders a page with a container for the recipe-list component" do
    u = users(:one)
    post signin_path, params: { email: u.email, password: 'secret' }

    get recipe_index_path
    expect(response.status).to eq(200)

    assert_select '#recipe-list-container', ''
  end

end
