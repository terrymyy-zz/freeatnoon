class CreateFreeTimes < ActiveRecord::Migration
  def change
    create_table :free_times do |t|
      t.integer :day
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
