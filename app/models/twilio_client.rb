# -*- coding: utf-8 -*-
class TwilioClient
  def initialize
    @client ||= Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
  end

  def send_sms(to, body, save = true)
    sms = { from: "+12679152717", to: to, body: body }
    @client.account.messages.create(sms)
    to_user = User.find_by_phone_number(to)
    sms[:to_user_id] = to_user.id if to_user
    if save
      Sms.create(sms)
    end
  end

  def respond_to_yes(to)
    promo_str = "Btw, if you know anyone else who’d dig Free At Noon, get them in the group so we can make more matches!"
    potential_msgs =
      ["Hell yea! We’ll follow up before noon if someone else is up to grab lunch.",
       "Okay, we’ll get back to you if someone else is also down to meet!",
       "Yes? Yes! Woohoo! We’ll let you know if someone else is also free at noon.",
       "We were hoping you’d say yes! We’ll follow up if there’s a match with someone else who’s free at noon.",
       "Booyah! We’ll follow up if there’s a match with someone else who’s free at noon.",
       "Wahoo!! We’ll follow up if there’s a match with someone else who’s free at noon.",
       "YAYYYYY. Great news. We’ll follow up if there’s a match with someone else who’s free at noon.",
       "Fantastic! We’ll follow up if there’s a match with someone else who’s free at noon.",
       "Great, thanks! We’ll follow up if there’s a match with someone else who’s free at noon."]
    msg = "%s %s" % [potential_msgs[rand(8)], promo_str]
    send_sms(to, msg)
  end

  def send_morning_sms(user)
    msg = "Good morning #{user.first_name}! Up for having lunch with someone today? (Please respond “yes” or “no”.)"
    send_sms(user.phone_number,msg)
  end

  def send_noon_sms(user)
    msg = "Hey there #{user.first_name}! We haven’t heard back about lunch today. Please let us know in the next 30 minutes! (Please respond “yes” or “no”.)"
    send_sms(user.phone_number,msg)
  end

end
