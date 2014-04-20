class RemoveEndTimeFromFreeTime < ActiveRecord::Migration
  def change
    remove_column :free_times, :end_time, :time
  end
end
