post '/users/:id/friends/:friend_id' do
	@friend = current_user.friends.new(user_id: params[:id], friend_user_id: params[:friend_id])
	if Friend.find_by(user_id: @friend.user_id, friend_user_id: @friend.friend_user_id).nil?
		@friend.save
	else Friend.where(user_id: @friend.user_id, friend_user_id: @friend.friend_user_id).delete_all
	end
	redirect "/users/#{params[:friend_id]}"
end