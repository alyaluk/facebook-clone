helpers do
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	def logged_in?
		current_user != nil
	end

	def login(user)
		session[:user_id] = user.id
	end

	def back_to_profile
		return "<a href=/users/" + "#{current_user.id}" + ">Go back to profile</a>" if logged_in?
	end

	def log_out
		return "<a href='/logout'>Log out and return to home page</a><br>" if logged_in?
	end
end