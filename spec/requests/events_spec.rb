require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /events" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          user: {
            full_name: "Aaron Gordon",
            email: "gordon@msudenver.edu",
            password: "password",
            password_confirmation: "password",
            user_type: "Student",
            college_name: "Metropolitan State University",
            created_events_count: 0,
            registered_events_count: 0
          }
        }
      end


      it "allows access to the events page" do
        # Create the user
        post user_registration_path, params: valid_params
        follow_redirect! 
        
        # Get events 
        get "/events"
        expect(response).to have_http_status(200)
        expect(response.body).to include("Events")
      end
    end

  end

  describe "CRUD methods on /events page" do
    context "" do
      let(:valid_params) do
        {
          user: {
            full_name: "Aaron Gordon",
            email: "gordon@msudenver.edu",
            password: "password",
            password_confirmation: "password",
            user_type: "Student",
            college_name: "Metropolitan State University",
            created_events_count: 0,
            registered_events_count: 0
          },
          event: {
            title: "Test Event",
            description: "A description of the new event.",
            location: "Tivoli Hall",
            start_time: "2024-12-15T14:00:00",
            end_time: "2024-12-15T16:00:00",
            status: "Scheduled"
          }
        }
      end


      it "GET /events displays create event page" do
        # Create the user
        post user_registration_path, params: valid_params
        follow_redirect! 
        
        # Get events 
        get "/events/new"

        # Check "Create an Event" page form
        expect(response).to have_http_status(200)
        expect(response.body).to include("Create an Event")

        expect(response.body).to include("Title")
        expect(response.body).to include("Description")
        expect(response.body).to include("Location")
        expect(response.body).to include("Start time")
        expect(response.body).to include("End time")
        expect(response.body).to include("Status")

        expect(response.body).to include("Upload Event")

      end

      it "POST /events/new  allows creating an event" do
        # Create the user
        post user_registration_path, params: valid_params
        follow_redirect! 
        
        get "/events/new"

        # Add event details
        post events_path, params: { event: valid_params[:event] }
        follow_redirect! 

        # Event created successfully
        expect(response).to have_http_status(200)
        expect(response.body).to include("Event was successfully created")
      end

      it "PUT /events/:id/edit allows updating an event" do
        # Create the user
        post user_registration_path, params: valid_params
        follow_redirect! 
        get "/events/new"

        # Add event details
        post events_path, params: { event: valid_params[:event] }
        follow_redirect! 

        # Event created successfully
        expect(response).to have_http_status(200)
        expect(response.body).to include("Event was successfully created")

        expect(response.body).to include("Edit Event")

        # Fetch the new event ID
        event = Event.last

        # PUT request to update the event
        updated_params = {
          event: {
            title: "Updated Event Title",
            description: "Updated description of the event.",
            location: "Updated Tivoli Hall",
            start_time: "2024-12-15T15:00:00",
            end_time: "2024-12-15T17:00:00",
            status: "Scheduled"
          }
        }

        put event_path(event), params: updated_params
        follow_redirect!

        # Check if the event was updated successfully
        expect(response).to have_http_status(200)
        expect(response.body).to include("Event was successfully updated")
        expect(Event.exists?(event.id)).to be(true) 

      end

      it "DELETE /events/:id/edit allows deleting an event" do
        # Create the user
        post user_registration_path, params: valid_params
        follow_redirect! 
        get "/events/new"

        # Add event details
        post events_path, params: { event: valid_params[:event] }
        follow_redirect! 

        # Event created successfully
        expect(response).to have_http_status(200)
        expect(response.body).to include("Event was successfully created")

        expect(response.body).to include("Delete Event")

        # get the new event ID
        event = Event.last

        # DELET request to the event
        delete event_path(event)
        follow_redirect!

        # Check if the event was updated successfully
        expect(response).to have_http_status(200)
        expect(response.body).to include("Event was successfully destroyed")

        expect(Event.exists?(event.id)).to be(false)
      end
    end

  end

end


#  rspec spec/requests/events_spec.rb