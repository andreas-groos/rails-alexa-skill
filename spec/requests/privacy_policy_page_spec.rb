require 'rails_helper'

RSpec.describe "privacy policy page", :type => :request do

  it "renders" do
    get "/privacy"
    expect(response.status).to eq(200)
  end

end