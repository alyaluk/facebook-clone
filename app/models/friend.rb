class Friend < ActiveRecord::Base
	belongs_to :user
	has_many :friend_user

	def self.all_friends(user)
		string = ""
		Friend.where(user_id: user).each do |x| 
			string << User.find_by(id: x.friend_user_id).display_full_with_link
		end
		return string
	end
end