class ChangeStartTimeInFreeTime < ActiveRecord::Migration
  def change
    def up
      change_column :free_times, :start_time, :decimal
    end

    def down
      change_column :free_times, :start_time, :time
    end
  end
end
