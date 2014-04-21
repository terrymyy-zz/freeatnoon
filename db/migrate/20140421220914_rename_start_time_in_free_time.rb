class RenameStartTimeInFreeTime < ActiveRecord::Migration
  def change
    rename_column :free_times, :start_time, :time
  end
end
