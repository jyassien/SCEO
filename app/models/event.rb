class Event < ApplicationRecord
  belongs_to :user
  has_many :flags, dependent: :destroy

  
  def creator
    user.username 
  end
end

