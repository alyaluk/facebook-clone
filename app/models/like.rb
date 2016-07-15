class Like < ActiveRecord::Base
	before_save :uniqueness_check

	belongs_to :user
	belongs_to :status

	def uniqueness_check
		user = self.user_id
		status_id = self.status_id
		lookup = Like.find_by(user_id: user, status_id: status_id)
		if lookup != nil
			self.like = 0 if (self.like == lookup.like)
			Like.delete(lookup.id) if (self.user_id == lookup.user_id) && (self.status_id == lookup.status_id)
		end
	end
end