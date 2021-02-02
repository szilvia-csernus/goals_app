class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
        return nil if self.session[:session_token].nil?
        @current_user ||= User.find_by(session_token: self.session[:session_token])
    end

    def require_current_user!
        redirect_to new_session_url if current_user.nil?
    end

    def require_remaining_cheer_to_give!
        redirect_back(fallback_location: root_url) if current_user.cheers_to_give_counter < 1
    end

    def log_in!(user)
        user.reset_session_token!
        self.session[:session_token] = user.session_token
    end

    def log_out!
        current_user.try(:reset_session_token!)
        self.session[:session_token] = nil
    end
end
