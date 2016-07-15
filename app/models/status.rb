class Status < ActiveRecord::Base
	validates :status, presence: {message: "Cannot be empty."}

	belongs_to :user

	def self.all_statuses(current_user_id)
		string = ""
		Status.all.order('id DESC').each do |x| 
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

	def display
		string = ""
		finished = false
		times = TimeDifference.between(self.created_at, Time.now).in_each_component
		string << "#{User.find_by(id: self.user_id).display_full_with_link}<br>"
		string << "#{self.status}<br>"
		times.each do |i,j|
			if j >= 1
				string << "#{j.round} #{i} ago" unless finished == true
				finished = true
			end
		end
		string << "<br><br>"
	end

	def show_likes
		string = ""
		string << "<form method=post action='/statuses/#{self.id}'>"
		string << "<input type='submit' value='+#{Like.where(status_id: self.id, like: 1).count}'></form>"
		return string
	end
end