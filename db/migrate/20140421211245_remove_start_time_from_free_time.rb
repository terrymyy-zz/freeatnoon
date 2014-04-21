class RemoveStartTimeFromFreeTime < ActiveRecord::Migration
  def change
    remove_column :free_times, :start_time, :time
  end
end
