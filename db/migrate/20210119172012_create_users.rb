class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string "username", null: false, uniqueness: true
      t.string "password_digest", null: false
      t.string "session_token", null: false
      t.integer "received_cheers_counter", null: false, default: 0
      t.integer "cheers_to_give_counter", null: false, default: 12
      t.timestamps
    end
  end
end   
