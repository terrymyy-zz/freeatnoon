class AddUserIdsToSmses < ActiveRecord::Migration
  def change
    add_column :sms, :from_user_id, :integer
    add_column :sms, :to_user_id, :integer
  end
end
