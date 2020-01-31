module SessionsHelper
    # logs in the given user 
    def log_in(user)
      session[:user_id] = user.id
    end
    #returns the currently logged_in user (if there is any logged_in user)
    def current_user
      if session[:user_id]
        @current_user ||= User.find_by(id: session[:user_id])
      end
    end
    # Have a function to determine of tha user is logged in
    def logged_in?
      !current_user.nil?
    end
    #logs out current user
    def log_out
    session.delete(:user_id)
    @current_user = nil
    end

    #returns the current loggedin user and
    #returns true is the given user is the current user
    def current_user?(user)
    user == current_user
    end

    # to avoid not logged-in users from making microposts
    def only_loggedin_users
      redirect_to login_url unless logged_in? # logged_in? is found in our SessionsHelper
    end
end
