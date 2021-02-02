require 'auth_helper'
require 'goal_helper'

def create_cheer!(goal)
    test_user = create(:user)
    cheer = Cheer.create!(user_id: test_user.id, goal_id: goal.id)
end