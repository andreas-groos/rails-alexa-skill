require 'rails_helper'

RSpec.describe "help page", :type => :request do

  it "renders" do
    get "/"
    expect(response.status).to eq(200)
  end

end