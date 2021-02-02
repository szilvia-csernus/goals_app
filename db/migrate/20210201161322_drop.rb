class Drop < ActiveRecord::Migration[5.2]
  def change
    drop_table :cheers
  end
end
