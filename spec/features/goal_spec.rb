require 'rails_helper'
require 'goal_helper'

feature "GOAL SPEC - User's show page" do

    before(:each) do
        capybara_create_user_with_goals!
    end

    scenario "newly created goals appear on page" do
        
        expect(page).to have_content "#{@test_user.username}'s Goals"
        expect(page).to have_link @test_goal.title
        expect(page).to have_content @private_goal.title
        
    end

    scenario "private links are shown on user's own show page" do
        
        expect(page).to have_button "Mark Completed"
        expect(page).to have_link "New Goal"
    end

    scenario 'has user\'s own private goals on page' do
        
        expect(page).to have_content "Private"      
    end

    scenario "has no other user's private goals on page" do
        
        click_on "Log Out"
        
        test_user_2 = build(:user)
        sign_up_user!(test_user_2.username, test_user_2.password)
        
        
        click_link("All Users")
        click_link(@test_user.username)
        
        expect(page).to have_content "#{@test_user.username}'s Goals"
        expect(page).to have_link @test_goal.title
        expect(page).not_to have_content @private_goal.title
        
        expect(page).not_to have_content "Private"
    end

    scenario "private links are not shown on other user's show page" do
        
        click_on "Log Out"

        test_user_2 = build(:user)
        sign_up_user!(test_user_2.username, test_user_2.password)
        
        click_link("All Users")
        click_link(@test_user.username)
        
        expect(page).not_to have_button "Mark Completed"
        expect(page).not_to have_link "New Goal"
    end
end

feature "Goal's show page" do

    before(:each) do
        capybara_create_user_with_goals!
    end

    scenario "shows expected content on page" do

        click_link(@test_goal.title)
  
        expect(page).to have_content(@test_goal.title)
        expect(page).to have_content("Description:")
        expect(page).to have_content(@test_goal.text)
        expect(page).to have_content("Visibility:")
        expect(page).to have_content("Public")
        expect(page).to have_content("Progress:")
        expect(page).to have_content("Ongoing")
        
        expect(page).to have_link("Back to User")
        click_link("Back to User")
        click_link(@private_goal.title)

        expect(page).to have_content("Private")
    end

    scenario "shows 'Edit/Delete Goal' buttons for user's own goals" do
        click_link(@test_goal.title)
  
        expect(page).to have_button("Edit Goal")
        expect(page).to have_button("Delete Goal")
    end

    scenario "does not show 'Edit/Delete Goal' buttons for other user's goals" do

        click_on "Log Out"
        test_user_2 = build(:user)
        sign_up_user!(test_user_2.username, test_user_2.password)

        click_link("All Users")
        click_link(@test_user.username)
        click_link(@test_goal.title)
  
        expect(page).not_to have_button("Edit Goal")
        expect(page).not_to have_button("Delete Goal")
    end

    scenario "'Edit Goal' link goes to the edit page" do
        click_link(@test_goal.title)
        click_button("Edit Goal")

        expect(page).to have_button("Update Goal")
    end

    scenario "clicking 'Update Goal' will update record" do
        click_link(@test_goal.title)
        click_button("Edit Goal")
        fill_in("Title", with: "Read through a night")
        fill_in("Description", with: "simply read!")
        choose("Private")
        choose("Completed")
        click_button("Update Goal")

        expect(page).to have_link("Read through a night")
        click_link("Read through a night")

        expect(page).to have_content("simply read!")
        expect(page).to have_content("Read through a night")
        expect(page).to have_content("Private")
        expect(page).to have_content("Complete")

        expect(page).not_to have_content("Public")
        expect(page).not_to have_content("Ongoing")
    end

    scenario "clicking 'Delete Goal' will destroy the goal" do
        click_link(@test_goal.title)
        click_button("Delete Goal")

        expect(page).to have_content("#{@test_user.username}'s Goals")
        expect(page).not_to have_link(@test_goal.title)
    end

    scenario "'Back to User' link takes back to the user's page" do
        click_link(@test_goal.title)
        click_link("Back to User")

        expect(page).to have_content("#{@test_user.username}'s Goals")
        
        click_button "Log Out"
    end
 
end


