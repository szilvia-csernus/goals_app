class Cheers < ActiveRecord::Migration[5.2]
  def change
    create_table :cheers do |t|
      t.integer :user_id, null: false
      t.integer :goal_id, null: false

      t.timestamps
    end
    add_index :cheers, [:user_id, :goal_id ], unique: true
  end
end
