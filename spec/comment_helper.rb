require 'auth_helper'
require 'goal_helper'


def capybara_create_user_comment!
    
    @test_user_comment = build(:comment)
  
    fill_in "Comment:", with: @test_user_comment.text
    click_button "Add Comment"
  
end

def capybara_create_goal_with_comment!(user)

    capybara_create_user_with_goal!

    click_link @test_goal.title

    @test_goal_comment = build(:comment)
    @test_goal_comment.user_id = user.id

    fill_in "Comment:", with: @test_goal_comment.text
    click_on "Add Comment"
end
