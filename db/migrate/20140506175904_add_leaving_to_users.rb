class AddLeavingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :leavingDate, :datetime
  end
end
