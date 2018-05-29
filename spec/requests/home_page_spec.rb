require 'rails_helper'

RSpec.describe "home page", :type => :request do

  it "displays a landing hero page with a wizard node when not signed in" do
    get "/"
    expect(response.status).to eq(200)
    assert_select '#wizard-container', ''
  end

  it "redirects to a users recipe list when signed in" do
    user = User.create!(
      :name => 'monica', :email => "monica@friends.com", :password => "secret", :password_confirmation => "secret"
    )
    post signin_path, params: { email: user.email, password: 'secret' }

    get '/'
    expect(response).to redirect_to recipe_index_path
  end

end
