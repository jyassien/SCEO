class Flag < ApplicationRecord
    belongs_to :user, foreign_key: 'flagged_by', optional: true
    belongs_to :event, optional: true
  end
  