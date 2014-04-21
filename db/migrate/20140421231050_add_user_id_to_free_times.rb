class AddUserIdToFreeTimes < ActiveRecord::Migration
  def change
    add_column :free_times, :user_id, :integer
  end
end
