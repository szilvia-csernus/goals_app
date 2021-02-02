require 'rails_helper'

RSpec.describe Cheer, type: :model do
  it { should validate_presence_of(:user_id)}
  it { should validate_presence_of(:goal_id)}
  
  describe 'associations' do
    it { should belong_to(:user)}
    it { should belong_to(:goal)}
  end

end
