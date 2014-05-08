class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :free_times
  has_many :bad_dates
  has_many :sent_messages, class_name: "Sms", foreign_key: "from_user_id"
  has_many :received_messages, class_name: "Sms", foreign_key: "to_user_id"

  def bad_dates_set
    @dates ||= bad_dates.map{|bd| bd.date}
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def format_phone_number
    self.phone_number = "+1"+self.phone_number.sub("+1","").tr('() -','')
    save
  end
end
