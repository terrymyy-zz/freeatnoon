class AddDurationToFreeTime < ActiveRecord::Migration
  def change
    add_column :free_times, :duration, :decimal
  end
end
