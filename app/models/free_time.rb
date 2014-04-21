class FreeTime < ActiveRecord::Base
  def to_s
    "day: #{day}, time: #{time}, duration: #{duration}"
  end
end
