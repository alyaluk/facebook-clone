post '/users/:id/status/new' do
	@status = current_user.statuses.new(params[:status])
	if @status.save
		@status.save
		redirect "/users/#{params[:id]}/wall"
	else flash[:error] = "Cannot submit an empty status."
		redirect "/users/#{params[:id]}/wall"
	end
end

post '/users/:id/status/:status_id/delete' do
	Status.delete(params[:status_id])
	redirect "/users/#{params[:id]}/wall"
end

post '/users/:id/status/:status_id' do
	redirect "/users/#{params[:id]}/status/#{params[:status_id]}/update"
end

get '/users/:id/status/:status_id/update' do
	@current_user = current_user
	@status = Status.find_by(id: params[:status_id])
	erb :"static/update"
end

post '/users/:id/status/:status_id/update' do
	Status.update(params[:status_id], status: params[:status][:updated_status])
	redirect "/users/#{params[:id]}/wall"
end

post '/statuses/:id' do
	@status = Status.find_by(id: params[:id])
	@user_id = current_user.id
	@like = Like.new(user_id: @user_id, status_id: @status.id, like: 1)
	@like.save
	redirect "/users/#{current_user.id}/wall"
end