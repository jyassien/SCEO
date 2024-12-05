require 'faker'
require 'open-uri'

# Clear existing data to avoid conflicts
Flag.delete_all
Event.delete_all
User.delete_all

VALID_REASONS = ["Inappropriate Content", "Spam", "Misleading Information", "Offensive Behavior", "Duplicate Event"]

# Create 10 users
users = []
10.times do |i|
  user = User.create!(
    full_name: Faker::Name.name,
    email: "user#{i + 1}@msudenver.edu",
    password: "password",
    user_type: ["admin", "professor", "student"].sample,
    college_name: Faker::University.name,
    created_events_count: 0,
    registered_events_count: 0
  )
  users << user
end

# Create 3 events for each user
users.each do |user|
  3.times do |j|
    capacity = rand(10..100)

    event = Event.create!(
      title: "Event #{user.id * 3 + j + 1}",
      description: Faker::Lorem.sentence(word_count: 15),
      location: Faker::Address.city,
      start_time: Faker::Time.between(from: DateTime.now, to: DateTime.now + 1.month),
      end_time: Faker::Time.between(from: DateTime.now + 1.month, to: DateTime.now + 2.months),
      status: ["scheduled", "completed", "cancelled"].sample,
      user: user,
      creator_name: user.full_name,
      capacity: capacity,
      registered_users_count: 0 
    )

    # Increment the created_events_count for the user
    user.increment!(:created_events_count)

    # Create 2 flags for each event
    2.times do
      Flag.create!(
        reason: VALID_REASONS.sample,
        description: Faker::Lorem.sentence(word_count: 10),
        flagged_at: Faker::Time.between(from: event.start_time, to: event.end_time),
        user: user,
        event: event
      )
    end
  end
end

# Register users for events 
events = Event.all
users.each do |user|
  5.times do
    event = events.reject { |e| e.user_id == user.id }.sample
    next if event.registered_users_count >= event.capacity 

    # Increment the registered events count
    user.increment!(:registered_events_count)
    event.increment!(:registered_users_count)
  end
end


puts "#{User.count} users, #{Event.count} events, and #{Flag.count} flags created."


# rails db:seed