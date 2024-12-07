FactoryBot.define do
    factory :user do
      full_name { "Aaron Gordon" }
      email { "gordon@msudenver.edu" }
      password { "password" }
      password_confirmation { "password" }
      user_type { "Student" }
      college_name { "Metropolitan State University" }
      created_events_count { 0 }
      registered_events_count { 0 }
    end
  end