get '/' do
	if logged_in? == false
		redirect '/login'
	else redirect "/users/#{current_user.id}/wall"
	end
	erb :"static/index"
end

get '/login' do
	erb :"static/login"
end

post '/login' do
	@user = User.find_by(email: params[:user][:email])
	if @user.nil?
		flash[:login_error] = "Account with this email does not exist."
		redirect '/login'
	elsif @user.authenticate(params[:user][:password])
		login(@user)
		redirect "/users/#{@user.id}/wall"
	else flash[:login_error] = "Incorrect password or email."
		redirect '/login'
	end
end

get '/logout' do
	session[:user_id] = nil
	redirect '/'
end