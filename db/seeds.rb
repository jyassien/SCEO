require 'faker'
require 'open-uri'

# Clear existing data to avoid conflicts
User.delete_all
Event.delete_all
Flag.delete_all

# Define a list of valid reasons for flagging an event
VALID_REASONS = ["Inappropriate Content", "Spam", "Misleading Information", "Offensive Behavior", "Duplicate Event"]

# Create 10 users
10.times do |i|
  user = User.create!(
    username: "user#{i + 1}",
    email: "user#{i + 1}@msudenver.edu", 
    password: "password", 
    user_type: ["admin", "professor", "student"].sample, 
    college_name: Faker::University.name
  )

  # Create 3 events for each user
  3.times do |j|
    event = Event.create!(
      title: "Event #{i * 3 + j + 1}",
      description: Faker::Lorem.sentence(word_count: 15),
      location: Faker::Address.city,
      start_time: Faker::Time.between(from: DateTime.now, to: DateTime.now + 1.month),
      end_time: Faker::Time.between(from: DateTime.now + 1.month, to: DateTime.now + 2.months),
      status: ["scheduled", "completed", "cancelled"].sample,  
      user: user,  
      flags_count: 0
    )

    # Create 2 flags for each event
    2.times do
      Flag.create!(
        reason: ["inappropriate", "illegal", "safety_concern", "other"].sample, 
        description: Faker::Lorem.sentence(word_count: 10),
        flagged_at: Faker::Time.between(from: event.start_time, to: event.end_time),
        user: user,  
        event: event 
      )
    end
  end
end

puts "10 users, 30 events, and 60 flags created."
