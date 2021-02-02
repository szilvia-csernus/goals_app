class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :text, null: false
      t.integer :user_id, null: false
      t.references :commentable, polymorphic: :true
    end
    add_index :comments, :user_id
    add_index :comments, [:commentable_id, :commentable_type]
  end
  
end
