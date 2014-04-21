class AddStartTimeToFreeTime < ActiveRecord::Migration
  def change
    add_column :free_times, :start_time, :decimal
  end
end
