require 'rails_helper'

RSpec.describe User, type: :model do

  it "allows a basic user to be created" do
    u = User.create(
      :name => 'Alice',
      :email => 'alice@test.com',
      :password => 'secret',
      :password_confirmation => 'secret'
    )
    expect(u.id).to be_truthy
  end

  it "assigns codewords sensibly enough" do
    u = User.create(
      :name => 'Alice',
      :email => 'alice@test.com',
      :password => 'secret',
      :password_confirmation => 'secret'
    )
    expect(u.codeword).to be_truthy

  end

  it "should normalize the email as a username" do
    u = User.create(
      :name => 'Alice',
      :email => '  ALICE@TEST.com  ',
      :password => 'secret',
      :password_confirmation => 'secret'
    )

    expect(u.id).to be_truthy
    expect(u.email).to eq("alice@test.com")
  end

end
