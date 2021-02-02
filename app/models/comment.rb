class Comment < ApplicationRecord
    validates :user_id, :text, :commentable_id, :commentable_type, presence: true

    belongs_to :user
    belongs_to :commentable, polymorphic: true
end