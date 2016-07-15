class CreateLikes < ActiveRecord::Migration
	def change
		create_table :likes do |t|
			t.integer :user_id, index: true, foreign_key: true
			t.integer :status_id, index: true, foreign_key: true, default: 0
			t.integer :like, default: 0
			t.timestamps
		end
	end
end