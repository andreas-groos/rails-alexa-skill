RSpec.describe "sign out endpoint", :type => :request do
  fixtures :users

  it "clears a session and signs the user out" do
    u = users(:one)
    post signin_path, params: { email: u.email, password: 'secret' }
    expect(session['user_id']).to be
    
    get signout_path
    expect(session['user_id']).to be_nil
  end


end