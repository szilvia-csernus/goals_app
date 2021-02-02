require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET #new" do
    it "renders the new template" do
      get :new, {}
      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the user's username and password" do
        post :create, params: { user: {password: "password"} } # no username
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present

        post :create, params: { user: {username: "email@email.com"} } # no password
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

      it "validates that the password is at least 6 characters long" do
        post :create, params: { user: {username: "email@email.com", password: "hello"} } # too short pw
        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "redirects user to user's show page on success" do
        test_user = build(:user)
        post :create, params: { user: {username: test_user.username, password: test_user.password } }
        expect(response).to redirect_to(user_url(User.find_by_credentials(test_user.username, test_user.password)))
        end
    end

  end

   describe "GET #index" do
   
    it "it renders the users index page" do
      
      get :index
      
      expect(response).to be_successful
      expect(response).to render_template(:index)

    end
 
  end

end
