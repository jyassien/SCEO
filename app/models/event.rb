class Event < ApplicationRecord
    belongs_to :user, foreign_key: 'creator', optional: true
    has_many :flags, dependent: :destroy
  end
  