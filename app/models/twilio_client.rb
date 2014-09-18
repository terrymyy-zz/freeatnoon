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
    # promo_str = "Btw, if you know anyone else who’d dig Free At Noon, get them in the group so we can make more matches!"
    promo_str = ""
    potential_msgs =
      ["Hell yea! As soon as we know if someone else is free at the same time, we'll put you in a groupme. Love, The FreeAtNoon Bot.",
       "ERMAHGERD YESSSS! As soon as we know if someone else is free at the same time, we'll put you in a groupme. Love, The FreeAtNoon Bot.",
       "Yes? Yes! Woohoo! As soon as we know if someone else is free at the same time, we'll put you in a groupme. Love, The FreeAtNoon Bot.",
       "We were hoping you’d say yes! As soon as we know if someone else is free at the same time, we'll put you in a groupme. Love, The FreeAtNoon Bot.",
       "Booyah! As soon as we know if someone else is free at the same time, we'll put you in a groupme. Love, The FreeAtNoon Bot.",
       "Wahoo!! As soon as we know if someone else is free at the same time, we'll put you in a groupme. Love, The FreeAtNoon Bot.",
       "YAYYYYY. Great news. As soon as we know if someone else is free at the same time, we'll put you in a groupme. Love, The FreeAtNoon Bot.",
       "Fantastic! As soon as we know if someone else is free at the same time, we'll put you in a groupme. Love, The FreeAtNoon Bot.",
       "Great, thanks! As soon as we know if someone else is free at the same time, we'll put you in a groupme. Love, The FreeAtNoon Bot."]
    msg = "%s %s" % [potential_msgs[rand(8)], promo_str]
    send_sms(to, msg)
  end

  def send_morning_sms(user)
    msg = "Hi there and good evening! Are you free at noon tomorrow to grab lunch/coffee with another member? We're trying something new and asking you tonight instead of tomorrow morning. (Pls respond “yes” or “no”.)"
    send_sms(user.phone_number,msg)
  end

  def send_noon_sms(user)
    msg = "Hey there #{user.first_name}! We haven’t heard back about lunch today. Please let us know in the next 30 minutes! (Please respond “yes” or “no”.)"
    send_sms(user.phone_number,msg)
  end

  def send_correction(user)
    msg = "Haha jk. We all know it's Monday :P"
    send_sms(user.phone_number,msg)
  end

  def send_welcome_sms(user)
    msg = "Hey #{user.first_name}! This is the FreeAtNoon bot; you can just call me FAN. Here’s what’s next: on the days you said you’re free, you’ll get a text from me in the morning. It will ask you if you’re still free for that day. You simply text back a “yes” or a “no.” If you send a “yes” and someone else is free at the same time, you’ll be put into a groupme with them. Then all you have to do is pick the place to meet. That’s it! Glad to have you as part of the FreeAtNoon group! Last thing, here’s a fun meme: http://bit.ly/SeriousImage. You earned it."
    send_sms(user.phone_number, msg, false)
  end
end
