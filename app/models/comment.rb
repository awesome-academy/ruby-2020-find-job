class Comment < ApplicationRecord
  acts_as_paranoid
  COMMENT_PARAMS = [:content, :user_id].freeze
  
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :content, length: {maximum: Settings.max_length_comment}, presence: true 
end
