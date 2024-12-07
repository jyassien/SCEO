require 'rails_helper'

RSpec.describe "Flags", type: :request do

  describe "GET /flags" do
    context "with valid parameters" do
      let(:valid_user_params) do
        {
          full_name: "Aaron Gordon",
          email: "gordon@msudenver.edu",
          password: "password",
          password_confirmation: "password",
          user_type: "Student",
          college_name: "Metropolitan State University",
          created_events_count: 0,
          registered_events_count: 0
        }
      end

      let(:valid_event_params) do
        {
          title: "Test Event",
          description: "A description of the new event.",
          location: "Tivoli Hall",
          start_time: "2024-12-15T14:00:00",
          end_time: "2024-12-15T16:00:00",
          status: "Scheduled"
        }
      end

      let(:valid_flag_params) do
        {
          reason: "Inappropriate content",
          description: "The event description contains inappropriate language.",
          user_id: nil, # Corrected user_id
          event_id: nil # Event id will be set when the event is created
        }
      end

      it "GET /flags reads the Flags page" do
        # Create the user
        post user_registration_path, params: { user: valid_user_params }
        follow_redirect! 
        
        # Get Flags 
        get "/flags"
        expect(response).to have_http_status(200)
        expect(response.body).to include("Flags")
      end

      it "POST /flags/new?event_id=<ID>&reason=<REASON>+Content adds a Flags to an event" do
        # Create the user
        post user_registration_path, params: { user: valid_user_params }
        follow_redirect! 
        user = User.last


        # Create an event 
        post events_path, params: { event: valid_event_params }
        follow_redirect! 
        expect(response.body).to include("Event was successfully created")
        
        # Fetch the user ID
        user = User.last
        valid_flag_params[:user_id] = user.id 

        # Fetch the event ID
        event = Event.last
        valid_flag_params[:event_id] = event.id 

        # Flag the event
        post "/flags/new", params: { flag: valid_flag_params }

        # follow_redirect!

        # Check the response for success message
        expect(response).to have_http_status(200)
        expect(response.body).to include("Event flagged successfully")
      end
    end
  end
end


#  rspec spec/requests/flags_spec.rb --format documentation





