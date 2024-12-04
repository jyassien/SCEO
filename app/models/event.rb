class Event < ApplicationRecord
  belongs_to :user
  has_many :flags, dependent: :destroy

  
  def creator
    user.full_name 
  end
end

