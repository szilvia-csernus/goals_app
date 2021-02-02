class RemoveCheersCounterFromGoals < ActiveRecord::Migration[5.2]
  def change
    remove_column :goals, :cheers_counter
  end
end
