class AddResponseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :response, :boolean
  end
end
