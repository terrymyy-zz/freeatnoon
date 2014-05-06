class CreateBadDates < ActiveRecord::Migration
  def change
    create_table :bad_dates do |t|
      t.integer :user_id
      t.date :date

      t.timestamps
    end
  end
end
