class Cheer < ApplicationRecord
    validates :user_id, :goal_id, presence: true
    validates :user_id, uniqueness: { scope: :goal_id, message: 'goal has been cheered by this user already'}

    belongs_to :user
    belongs_to :goal
end
