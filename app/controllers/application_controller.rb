class ApplicationController < ActionController::Base
    def after_sign_out_path_for(resource_or_scope)
        root_path # Redirect to the homepage after sign-out
    end
end
