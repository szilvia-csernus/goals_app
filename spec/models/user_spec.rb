require 'rails_helper'

RSpec.describe User, type: :model do
  
  subject(:initial_user) { create(:user)}
  let(:test_user) { create(:user)}

  it { should validate_presence_of(:username)}
  it { should validate_uniqueness_of(:username)}
  it { should validate_numericality_of(:cheers_to_give_counter)}

  it "fails validation if password length is <= 6" do
      short_pw_user = build(:user, password: "hello")
      expect(short_pw_user).not_to be_valid
  end

  it 'fails validation with no password_digest expecting a specific message' do
    no_pw_user = User.new(username: "hi@hi.com")
    no_pw_user.valid? #sets the error hash
    expect(no_pw_user).not_to be_valid
    expect(no_pw_user.errors[:password_digest]).to include('Password can\'t be blank')
    
  end

  context "#is_password?" do
    it "returns true if the right password is passed" do
      right_password = test_user.password
      expect(test_user.is_password?(right_password)).to be true
    end

    it "returns false if the wrong password is passed" do
      expect(test_user.is_password?("wrong_password")).to be false
    end
  end

    
  it "#reset_session_token! sets a new session token when called" do
    original_session_token = test_user.session_token
    test_user.reset_session_token!
    expect(test_user.session_token).not_to be(original_session_token)
  end

  it "::find_by_credentials finds user with given username&password" do
    test_user_find = User.find_by_credentials(test_user.username, test_user.password)
    expect(test_user.id).to eq(test_user_find.id)
  end

  it "::find_by_credentials will not return a user if called with wrong credentials" do
    test_user_find = User.find_by_credentials("non_existing@example.com", "hello123")
    expect(test_user_find).to be nil
  end
  
  describe 'associations' do
    it { should have_many(:goals)}
    it { should have_many(:cheers)}
    it { should have_many(:given_comments)}
    it { should have_many(:comments)}
  end
end

