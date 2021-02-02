require 'rails_helper'
require 'comment_helper'
require 'goal_helper'

RSpec.describe CommentsController, type: :controller do
    
    before(:each) do
        @user1 = create(:user)
    end
    
    describe "POST #create user comment" do

        before(:each) do
            @user2 = create(:user) 
            allow(controller).to receive(:current_user).and_return(@user1)
        end

        context "with invalid params" do
            it "does not create comment" do
                
                @test_user_comment = build(:comment, text: "") # no text
                post :create, params: { user_id: @user2.id, comment: { text: @test_user_comment.text }} 

                expect(response).to redirect_to user_url(@user2)
                expect(flash[:errors]).to be_present
            end
        end

        context "with valid params" do
            it "creates goal and redirects to user's show page" do
                
                @test_user_comment = build(:comment)
                post :create, params: { user_id: @user2.id, comment: { text: @test_user_comment.text }} 

                expect(response).to redirect_to user_url(@user2)
                expect(flash[:errors]).not_to be_present
            end
        end

    end

    describe "POST #create goal comment" do

        before(:each) do
            @test_goal = create_goal!
            allow(controller).to receive(:current_user).and_return(@user1)
        end

        context "with invalid params" do
            it "does not create comment" do
                
                @test_goal_comment = build(:comment, text: "")  # no text

                post :create, params: { goal_id: @test_goal.id, comment: { text: @test_goal_comment.text}}

                expect(response).to redirect_to goal_url(@test_goal)
                expect(flash[:errors]).to be_present
            end
        end

        context "with valid params" do
            it "creates goal and redirects to goal's show page" do
                
                @test_goal_comment = build(:comment)
                post :create, params: { goal_id: @test_goal.id, comment: { text: @test_goal_comment.text}} 

                expect(response).to redirect_to goal_url(@test_goal)
                expect(flash[:errors]).not_to be_present
            end
        end

    end

end
