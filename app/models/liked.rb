class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates_uniqueness_of :likeable_id, scope: [:user_id, :likeable_type]
end
