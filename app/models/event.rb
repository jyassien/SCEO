class Event < ApplicationRecord
  belongs_to :user
  
  def creator
    user.username 
  end
end

