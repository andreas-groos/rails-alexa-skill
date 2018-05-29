RSpec.describe "sign in endpoint", :type => :request do
  fixtures :users

  it "allows a user to sign in with valid credentials" do
    u = users(:one)
    post signin_path, params: { email: u.email, password: 'secret' }
    result = JSON.parse response.body

    expect(result['success']).to be_truthy
    expect(session['user_id']).to be
  end

  it "does not allow a user to sign in without valid credentials" do
    u = users(:one)
    post signin_path, params: { email: u.email, password: 'wrong' }
    result = JSON.parse response.body

    expect(result['success']).to be_falsey
    expect(session['user_id']).to be_nil

    # Let's follow it up with a non-existent email
    post signin_path, params: { email: 'emaildoesnotexistindb@test.com', password: 'secret' }
    expect(result['success']).to be_falsey
    expect(session['user_id']).to be_nil

  end

end