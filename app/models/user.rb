class User < ActiveRecord::Base
	validates :email, uniqueness: {message: "An account already exists under that email address."}, format: {with: /.+@.+\..+/, message: "Please enter a valid email address."}, presence: {message: "Email address required."}
	validates :full_name, presence: {message: "Full name required."}
	has_secure_password
	before_save :split_name

	has_many :statuses
	has_many :likes
	has_many :friends

	def split_name
		split = self.full_name.split.map(&:capitalize)
		first_name = split[0]
		self.first_name = first_name
		self.full_name = split.join(" ")
	end

	def has_s?
		split = self.full_name.split("")
		if split[-1] == "s"
			return "'"
		else return "'s"
		end
	end

	def add_status(user_id)
		array = []
		if self.id == user_id
			array << "<form method=post action='/users/#{user_id}/status/new'>"
			array << "<input type=text placeholder='Update your status.' name='status[status]'><br>"
			array << "<input type=submit value='Submit'></form><br>"
		return array.join("")
		end
	end

	def display_first_with_link
		return "<a href=/users/#{self.id}>#{self.first_name}</a>"
	end

	def display_full_with_link
		return "<a href=/users/#{self.id}>#{self.full_name}</a>"
	end

	def self.all_users(current_user)
		string = ""
		User.all.each do |x| 
			if x.full_name != current_user
			string << x.display_full_with_link + "<br>"
			end
		end
		return string
	end

	def user_statuses(current_user_id)
		string = ""
		Status.where(user_id: self.id).order('id DESC').each do |x| 
			finished = false
			times = TimeDifference.between(x.created_at, Time.now).in_each_component
			string << "#{User.find_by(id: x.user_id).display_full_with_link}<br>"
			string << "#{x.status}<br>"
			times.each do |i,j|
				if j >= 1
					string << "#{j.round} #{i} ago" unless finished == true
					finished = true
				end
			end
			string << x.show_likes
			if x.user_id == current_user_id
				string << "<form method=post action='/users/#{x.user_id}/status/#{x.id}/delete'>"
				string << "<input type=submit value='Delete status'></form>"
				string << "<form method=post action='/users/#{x.user_id}/status/#{x.id}'>"
				string << "<input type=submit value='Update status'></form>"
			else string << "<br><br>"
			end
		end
		return string
	end

	def show_likes
		string = ""
		string << "<form method=post action='/statuses/#{self.id}'>"
		string << "<input type='submit' value='+#{Like.where(status_id: self.id, like: 1).count}'></form>"
		return string
	end

	def add_friend(current_user_id)
		string = ""
		if self.id != current_user_id
			if Friend.find_by(user_id: current_user_id, friend_user_id: self.id).nil?
				string << "<form method=post action='/users/#{current_user_id}/friends/#{self.id}'>"
				string << "<input type=submit value='Add as friend'></form>" 
			else string << "<form method=post action='/users/#{current_user_id}/friends/#{self.id}'>"
				string << "<input type=submit value='Remove from friends'></form>" 
			end
		end
		return string
	end
end

