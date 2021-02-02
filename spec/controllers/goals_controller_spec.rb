require 'rails_helper'
require 'goal_helper'

RSpec.describe GoalsController, type: :controller do
    describe "GET #new" do
        it "renders the new template" do
            test_user = create(:user)
        get :new, params: { user_id: test_user.id }
        expect(response).to render_template("new")
        expect(response).to have_http_status(200)
        end
    end

  describe "POST #create" do
    context "with invalid params" do
      it "does not create goal" do
        test_user = create(:user)
        test_goal = build(:goal)
        post :create, params: { user_id: test_user.id, goal: { title: nil,
                                                        private: test_goal.private,
                                                        finished: test_goal.finished}} # no title

        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "creates goal and redirects to user's show page" do
        test_user = create(:user)
        test_goal = build(:goal)
        post :create, params: { user_id: test_user.id, goal: {
                                                        title: test_goal.title,
                                                        private: test_goal.private,
                                                        finished: test_goal.finished}}
        expect(response).to redirect_to(user_url(test_user))
        end
    end

  end

    describe "GET #edit" do
        it "renders the :edit template" do
            test_goal = create_goal!
            get :edit, params: { id: test_goal.id }
            expect(response).to render_template("edit")
            expect(response).to have_http_status(200)
        end
    end

  describe "POST #update" do
    context "with invalid params" do
      it "does not update goal" do
        
        test_goal = create_goal!

        post :update, params: { id: test_goal.id, goal: { title: nil,
                                                        private: test_goal.private,
                                                        finished: test_goal.finished}} # no title

        expect(response).to render_template("edit")
        expect(flash[:errors]).to be_present
      end
    end

    context "with valid params" do
      it "updates goal and redirects to user's show page" do
        
        test_goal = create_goal!
        post :update, params: { id: test_goal.id, goal: { title: test_goal.title,
                                                        private: test_goal.private,
                                                        finished: test_goal.finished}}
        expect(response).to redirect_to(user_url(User.find_by(id: test_goal.user_id)))
        end
    end

  end

    describe "GET #flip_progress" do
        it "sets self.finished false if it was true " do
        test_goal = create_goal!
        expect(test_goal.finished).to be false
        get :flip_progress, params: { id: test_goal.id }
        test_goal = Goal.find_by(id: test_goal.id)
        expect(test_goal.finished).to be true

        user = User.find_by(id: test_goal.user_id)
        expect(response).to redirect_to(user_url(user))
        end

        it "sets self.finished true if it was false " do
        test_goal = create_goal!
        expect(test_goal.finished).to be false
        get :flip_progress, params: { id: test_goal.id }
        test_goal = Goal.find_by(id: test_goal.id)
        expect(test_goal.finished).to be true
        get :flip_progress, params: { id: test_goal.id }
        test_goal = Goal.find_by(id: test_goal.id)
        expect(test_goal.finished).to be false

        user = User.find_by(id: test_goal.user_id)
        expect(response).to redirect_to(user_url(user))
        end
  end


end
