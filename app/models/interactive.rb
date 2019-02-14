class Interactive < ApplicationRecord
  belongs_to :user
  belongs_to :story
  scope :type_like, -> {where interactive_type: Interactive::LIKE}
  LIKE = 1
  FOLLOW = 2
end
