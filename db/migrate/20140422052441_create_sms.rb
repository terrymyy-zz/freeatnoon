class CreateSms < ActiveRecord::Migration
  def change
    create_table :sms do |t|
      t.string :from
      t.string :to
      t.string :body

      t.timestamps
    end
  end
end
