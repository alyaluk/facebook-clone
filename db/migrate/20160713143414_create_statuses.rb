class CreateStatuses < ActiveRecord::Migration
	def change
		create_table :statuses do |t|
			t.integer :user_id, index: true, foreign_key: true
			t.text :status, null: false
			t.timestamps
		end
	end
end