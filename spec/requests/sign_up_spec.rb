RSpec.describe "sign up endpoint", :type => :request do
  fixtures :users

  it "allows a user to sign up for an account" do
    post create_user_path, params: { name: 'novel', email: 'novel@repeatmyrecipes.com', password: 'secret' }
    result = JSON.parse response.body

    expect(result['success']).to be_truthy
    expect(session['user_id']).to be
  end

  it "applies some basic name validation to a signup request" do
    post create_user_path, params: { name: '', email: 'novel@repeatmyrecipes.com', password: 'secret' }
    result = JSON.parse response.body

    expect(result['success']).to be_falsey
    expect(result['errors']['name']).to be_truthy
    expect(session['user_id']).to be_nil
  end

  it "applies some basic email validation to signup request" do
    post create_user_path, params: { name: 'faker', email: 'thisdoesntlooklikeanemail', password: 'secret' }
    result = JSON.parse response.body

    expect(result['success']).to be_falsey
    expect(result['errors']['email']).to be_truthy
    expect(session['user_id']).to be_nil
  end

  it "applies some basic password validation to signup request" do
    post create_user_path, params: { name: 'novel', email: 'novel@repeatmyrecipes.com', password: '' }
    result = JSON.parse response.body

    expect(result['success']).to be_falsey
    expect(result['errors']['password']).to be_truthy
    expect(session['user_id']).to be_nil
  end

  it "does not allow duplicate emails regardless of case" do
    existing_user = users(:one)

    post create_user_path, params: { name: 'bob', email: existing_user.email, password: 'secret' }
    result = JSON.parse response.body
    expect(result['success']).to be_falsey
    expect(session['user_id']).to be_nil

    post create_user_path, params: { name: 'bob', email: existing_user.email.upcase, password: 'secret' }
    result = JSON.parse response.body
    expect(result['success']).to be_falsey
    expect(session['user_id']).to be_nil
  end

end