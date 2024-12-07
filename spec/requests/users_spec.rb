require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/sign_up" do
    # Signup 
    it "returns a successful response and displays the signup form" do
      get new_user_registration_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Sign Up") 
    end
  end

  describe "POST /users" do
    # Valid signup 
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
      it "creates a new user and redirects to the user profile page" do
        expect {
          post user_registration_path, params: valid_params
        }.to change(User, :count).by(1)

        expect(response).to redirect_to(user_path(User.last))
      end

      it "GET /users can Sing In with the newly created account" do
        # Sign up 
        post user_registration_path, params: valid_params  # 
        new_user = User.find_by(email: "gordon@msudenver.edu")

        # # Sign In
        post user_session_path, params: { user: { email: new_user.email, password: valid_params[:user][:password] } }

        # # Expect "Metropolitan State University" of College name for the user
        expect(response).to redirect_to(user_path(User.last))
        follow_redirect!
        expect(response.body).to include("Metropolitan State University")
      end
    end

    # Invalid signup 
    context "with empty password" do
      let(:invalid_params) do
        {
          user: {
            full_name: "Aaron Gordon",
            email: "gordon@msudenver.edu",
            password: "",
            password_confirmation: "password",
            user_type: "Student",
            college_name: "Metropolitan State University",
            created_events_count: 0,
            registered_events_count: 0
          }
        }
      end
      it "does not create a new user and re-renders the signup form with errors" do
        expect {
          post user_registration_path, params: invalid_params
        }.to change(User, :count).by(0)

        expect(response.body).to include("Password can&#39;t be blank")
      end
    end

    context "with invalid email" do
      let(:invalid_params) do
        {
          user: {
            full_name: "Aaron Gordon",
            email: "invalid",
            password: "password",
            password_confirmation: "password",
            user_type: "Student",
            college_name: "Metropolitan State University",
            created_events_count: 0,
            registered_events_count: 0
          }
        }
      end
      it "does not create a new user and re-renders the signup form with errors" do
        expect {
          post user_registration_path, params: invalid_params
        }.to change(User, :count).by(0)

        expect(response.body).to include("Email is invalid")
      end
    end
  end

end


#  rspec spec/requests/users_spec.rb