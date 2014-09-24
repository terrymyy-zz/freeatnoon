class AddExplainedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :explained, :boolean, default: false
  end
end
