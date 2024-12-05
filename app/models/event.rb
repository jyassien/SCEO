class Event < ApplicationRecord
  belongs_to :user
  has_many :flags, dependent: :destroy

  validates :creator_name, presence: true

  def creator
    user.full_name 
  end
end

