class CreateFriends < ActiveRecord::Migration
	def change
		create_table :friends do |t|
			t.integer :user_id, index: true, foreign_key: true
			t.integer :friend_user_id, index: true, foreign_key: true, default: 0
			t.timestamps
		end
	end
end
