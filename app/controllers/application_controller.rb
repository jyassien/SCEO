class ApplicationController < ActionController::Base
    #configure_permitted_parameters: method runs before each Devise controller action.
    before_action :configure_permitted_parameters, if: :devise_controller?
        def after_sign_in_path_for(resource)
         # Redirect to the user's profile after log in using devise 
            user_path(current_user) 
        end

        def after_sign_in_path_up(resource)
            # Redirect to the users's profile after log in using devise 
            user_path(current_user) 
        end

    protected

    def configure_permitted_parameters
        # parameters allowed during sign up and updates
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :user_type, :college_name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username, :user_type, :college_name])
    end

    def after_sign_out_path_for(resource_or_scope)
        root_path # Redirect to the homepage after sign-out
    end
end
