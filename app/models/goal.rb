class Goal < ApplicationRecord

    include Commentable

    validates :user_id, :title, presence: true

    belongs_to :user
    has_many :cheers, dependent: :destroy

    def flip_progress!
        self.toggle(:finished)
        self.save!
    end

    def cheers_counter
        self.cheers.count 
    end
end
