class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
        def after_sign_in_path_for(resource)
         # Redirect to the user profile
            user_path(current_user) 
        end

        def after_sign_in_path_up(resource)
            user_path(current_user) 
        end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :user_type, :college_name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :user_type, :college_name])
    end

    def after_sign_out_path_for(resource_or_scope)
        root_path # Redirect to the homepage
    end
end
