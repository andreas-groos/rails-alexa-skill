require 'rails_helper'

RSpec.describe "terms of service page", :type => :request do

  it "renders" do
    get "/terms"
    expect(response.status).to eq(200)
  end

end