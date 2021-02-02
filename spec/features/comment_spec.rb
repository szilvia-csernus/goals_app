require 'rails_helper'
require 'comment_helper'
require 'auth_helper'

feature "COMMENT SPEC - User's show page" do

    before(:each) do
        @test_user_1 = create(:user)
        @test_user_2 = create(:user)
        log_in_user!(@test_user_2)
        visit user_url(@test_user_1) # @test_user_2 is signed is 'current_user'
        # @test_user_2 is creating comment for @test_user_1 and stays on @test_user_1's :show page
        capybara_create_user_comment! 
    end

    scenario "'Add Comment' button and comments appear on page" do
        
        expect(page).to have_button "Add Comment"
        expect(page).to have_content "Comments"
        expect(page).to have_content @test_user_comment.text
        
    end

    scenario "comment is linked to the right user" do
        
        click_link "All Users"
        click_link @test_user_2.username
        
        expect(page).not_to have_content @test_user_comment.text
        
        click_link("All Users")
        click_link(@test_user_1.username)
        
        expect(page).to have_content @test_user_comment.text
        
    end

end

feature "Goal's show page" do

    before(:each) do
        capybara_sign_up_test_user_1!
        capybara_create_goal_with_comment!(@test_user_1)
    end

    scenario "shows expected content on page" do

        expect(page).to have_button "Add Comment"
        expect(page).to have_content "Comments"
        expect(page).to have_content @test_goal_comment.text
        
    end

    scenario "comment is linked to the right goal" do
        
        click_link "Back to User"
        click_link "All Users"
        #leaves @test_user's page and visits own page where there is no goal or goal comment
        click_link @test_user_1.username 

        expect(page).not_to have_link @test_goal.title
        expect(page).not_to have_content @test_goal_comment.text
        
        click_link "All Users"
        #goes back to @test_user's page where the goal and its comment is present
        click_link @test_user.username

        expect(page).to have_content @test_goal.title
        
        click_link @test_goal.title
        expect(page).to have_content @test_goal_comment.text
        
    end

end