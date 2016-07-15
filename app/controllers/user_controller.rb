get '/users/:id' do 
	@current_user = current_user
	@user = User.find_by(id: params[:id])
	erb :"static/profile"
end

get '/users/:id/wall' do 
	@current_user = current_user
	@user = User.find_by(id: params[:id])
	redirect "users/#{@user.id}" if @current_user.id != @user.id
	erb :"static/wall"
end

post '/users' do
	@user = User.new(params[:user])
	if @user.save
		login(@user)
		redirect "/users/#{@user.id}"
	else flash[:create_error] = "An account with this email already exists."
		redirect '/login'
	end
end