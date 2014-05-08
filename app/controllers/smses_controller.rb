# -*- coding: utf-8 -*-
class SmsesController < ApplicationController
  def index
    if is_admin?
      @smses = Sms.all
    end
  end

  def create
    twilio.send_sms(params[:sms][:to], params[:sms][:body])
    redirect_to users_path
  end

  def send_welcome_message
    msg = "Hey #{current_user.first_name}! Each morning, on days you’re not unavailable, the system will shoot you a text asking if you’re free to grab lunch with a member of the group. You simply respond “yes” or “no”. If yes, and we see a match, we’ll pair you up in a Groupme so you two can pick the place. That’s it!

Stoked to have you as part of the Free at Noon group. See ya soon!"
    twilio.send_sms(current_user.phone_number, msg, false)
    render json: { result: "success" }
  end

  # triggered when our twilio number receives a message
  def twiml
    sms = { from: params[:From],
            to: params[:To],
            body: params[:Body] }

    from_user = User.find_by_phone_number(params[:From])
    sms[:from_user_id] = from_user.id if from_user
    to_user = User.find_by_phone_number(params[:To])
    sms[:to_user_id] = to_user.id if to_user

    # save the message into the DB
    @sms = Sms.create(sms)
    from_user = @sms.from_user

    # response logic
    if sms[:body].downcase.include?("yes")
      @randNumber = rand(7);
      @stringToSend = "";
      @promoString = "Btw, if you know anyone else who’d dig Free At Noon, get them in the group so we can make more matches!";
      case @randNumber
      when 0
        @stringToSend = "Hell yea! We’ll follow up before noon if someone else is up to grab lunch.";
      when 1
        @stringToSend = "Okay, we’ll get back to you if someone else is also down to meet!";
      when 2
        @stringToSend = "Yes? Yes! Woohoo! We’ll let you know if someone else is also free at noon.";
      when 3
        @stringToSend = "We were hoping you’d say yes! We’ll follow up if there’s a match with someone else who’s free at noon.";
      when 4
        @stringToSend = "Booyah! We’ll follow up if there’s a match with someone else who’s free at noon.";
      when 5
        @stringToSend = "Wahoo!! We’ll follow up if there’s a match with someone else who’s free at noon.";
      when 6
        @stringToSend = "YAYYYYY. Great news. We’ll follow up if there’s a match with someone else who’s free at noon.";
      when 7
        @stringToSend = "Fantastic! We’ll follow up if there’s a match with someone else who’s free at noon.";
      else
        @stringToSend = "Great, thanks! We’ll follow up if there’s a match with someone else who’s free at noon."
      end
      @stringToSend << @promoString; 
      twilio.send_sms(sms[:from], @stringToSend)

      if from_user
        from_user.response = true
        from_user.save
      end
    elsif sms[:body].downcase.include?("no")
      twilio.send_sms(sms[:from], "Got it. Won't bother you today.")
      if from_user
        from_user.response = false
        from_user.save
      end
    end

    # Empty response to Twilio (Do nothing more)
    render xml: Twilio::TwiML::Response.new.text
  end

  def twilio
    @client ||= TwilioClient.new
  end
end
