class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :full_name, null: false
			t.string :first_name
			t.string :email, null: false
			t.string :password_digest, null: false
			t.timestamps
		end
	end
end
