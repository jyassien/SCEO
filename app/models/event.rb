class Event < ApplicationRecord
  belongs_to :user, counter_cache: :created_events_count
  has_many :flags, dependent: :destroy

  validates :creator_name, presence: true
  validates :capacity, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validate :check_capacity


  FILTER_OPTIONS = ["All", "Upcoming", "Scheduled", "Completed", "Cancelled", "No Flag"]

  def creator
    user.full_name 
  end

  private

  def check_capacity
    if registered_users_count > capacity
      errors.add(:registered_users_count, "cannot exceed the event capacity.")
    end
  end
end

