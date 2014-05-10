class AddMuteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mute, :boolean, default: false
  end
end
