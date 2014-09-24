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
    msg = "Hey #{user.first_name}! Are you free today to grab coffee/lunch with another member at the time you put down for today? Love, The FreeAtNoon Bot.

    (Pls text back “yes” or “no”.)"
    send_sms(user.phone_number,msg)
    user.response = nil
    user.save
  end

  def send_welcome_sms(user)
    msg = "Hey #{user.first_name}! I'm the FreeAtNoon bot; you can just call me F@N. Here’s what’s next: on the days you said you’re free, you’ll get a text from me in the morning. It will ask you if you’re still free for that day. You simply text back a “yes” or a “no.” If you send a “yes” and someone else is free at the same time, you’ll be put into a groupme with them. Then all you have to do is pick the place to meet. That’s it! Glad to have you as part of the FreeAtNoon group! Last thing, it's important you see this: http://bit.ly/SeriousImage."
    send_sms(user.phone_number, msg, false)
  end

  def send_policy(user)
    msg = "[Our matching policy here]"
    send_sms(user.phone_number,msg)
  end
end
