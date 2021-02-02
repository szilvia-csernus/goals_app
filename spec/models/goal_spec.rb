require 'rails_helper'
require 'goal_helper'
require 'cheer_helper'

RSpec.describe Goal, type: :model do
  
  it { should validate_presence_of(:user_id)}
  it { should validate_presence_of(:title)}

  
  describe 'associations' do
    it { should belong_to(:user)}
    it { should have_many(:cheers)}
    it { should have_many(:comments)}
  end

  context "#cheers_counter" do
    it "keeps track of goal's cheers count" do
      goal = create_goal!
      expect(goal.cheers_counter).to eq(0)

      create_cheer!(goal)
      expect(goal.cheers_counter).to eq(1)

      cheer = create_cheer!(goal)
      user = User.find_by(id: cheer.user_id)
      expect(goal.cheers_counter).to eq(2)

      #destroy the user who created the last cheer (its cheer gets destroyed too)
      user.destroy
      expect(goal.cheers_counter).to eq(1)
    
    end
  end

  context "#flip_progress!" do
    it "sets self.finished false if it was true " do
      test_goal = create_goal!
      expect(test_goal.finished).to be false
      test_goal.flip_progress!
      expect(test_goal.finished).to be true
    end

    it "sets self.finished true if it was false " do
      test_goal = create_goal!
      expect(test_goal.finished).to be false
      test_goal.flip_progress!
      expect(test_goal.finished).to be true
      test_goal.flip_progress!
      expect(test_goal.finished).to be false
    end
  end

end
