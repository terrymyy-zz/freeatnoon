class FreeTime < ActiveRecord::Base
  belongs_to :user

  def to_s
    "day: #{day}, time: #{time}, duration: #{duration}"
  end
end
