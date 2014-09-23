# -*- coding: utf-8 -*-
class SmsesController < ApplicationController
  def index
    if is_admin?
      @smses = Sms.order(:created_at)
    end
  end

  def create
    twilio.send_sms(params[:sms][:to], params[:sms][:body])
    redirect_to users_path
  end

  def send_welcome_message
    twilio.send_welcome_sms(current_user)
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
    if from_user && from_user.response.nil?
      if sms[:body].downcase.include?("yes")
        twilio.respond_to_yes(sms[:from])
        from_user.response = true
        from_user.save
      elsif sms[:body].downcase.include?("no")
        twilio.send_sms(sms[:from], "Got it. Have a great day!")
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
