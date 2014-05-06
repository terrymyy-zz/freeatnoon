class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :leavingDate, :leaving_date
  end
end
