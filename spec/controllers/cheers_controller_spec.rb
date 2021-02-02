require 'rails_helper'
require 'goal_helper'

RSpec.describe CheersController, type: :controller do
    
    before(:each) do
        @user1 = create(:user)
        @test_goal = create_goal!
        @user2 = User.find_by(id: @test_goal.user_id)
        
        allow(controller).to receive(:current_user).and_return(@user1) # simulate that @user1 has signed in
        allow(controller).to receive(:require_current_user!).and_return(true)
        allow(controller).to receive(:require_remaining_cheer_to_give!).and_return(true)
    end
    
    describe "POST #new cheer" do

        context "does not create cheer" do
            it "with invalid goal ID" do
                
                post :new, params: { goal_id: -1 } # goal does not exist

                expect(response).to redirect_to root_url
            end
        
        end

        context "with valid params" do
            it "creates cheer and redirects to user's show page" do
               
                post :new, params: { goal_id: @test_goal.id } 

                expect(response).to redirect_to user_url(@user2)
            end
        end

    end

end
