class RemoveReceivedCheersCounterFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :received_cheers_counter
  end
end
