class Flag < ApplicationRecord
  belongs_to :user
  belongs_to :event, counter_cache: true



  VALID_REASONS = ["Inappropriate Content", "Spam", "Misleading Information", "Offensive Behavior", "Duplicate Event"]

  validates :reason, inclusion: { in: VALID_REASONS, message: "%{value} is not a valid reason" }

  
end
