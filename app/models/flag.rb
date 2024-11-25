class Flag < ApplicationRecord
  belongs_to :user
  belongs_to :event, counter_cache: true


  enum reason: { inappropriate: 0, illegal: 1, safety_concern: 2, other: 3 }


  validates :reason, presence: true
end
