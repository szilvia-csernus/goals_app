require 'auth_helper'

def create_goal!
  test_user = create(:user)
  test_goal = build(:goal)
  test_goal.user_id = test_user.id
  test_goal.save
  test_goal
end

def capybara_create_goal!(test_goal, private = false)
  click_link "New Goal"
  fill_in "Title", with: test_goal.title
  fill_in "Description", with: test_goal.text
  choose('Private') if private
  click_on "Add Goal"
end

def capybara_create_user_with_goal!
    @test_user = build(:user)
    sign_up_user!(@test_user.username, @test_user.password)
    @test_goal = build(:goal)
    capybara_create_goal!(@test_goal)
end

def capybara_create_user_with_goals!
    
    capybara_create_user_with_goal!
    @private_goal = build(:goal)
    capybara_create_goal!(@private_goal, true)
end
