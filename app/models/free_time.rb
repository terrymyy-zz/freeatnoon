class FreeTime < ActiveRecord::Base
  belongs_to :user

  def to_s
    "day: #{day}, time: #{time}, duration: #{duration}"
  end

  def format
    "%s-%s" % [format_time(time), format_time(time+duration)]
  end

  def format_time(t)
    "%02d:%02d" % [t.to_i, (60*(t % 1)).round]
  end
end
