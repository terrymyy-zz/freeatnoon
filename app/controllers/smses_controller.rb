# -*- coding: utf-8 -*-
class SmsesController < ApplicationController
  def create
    sms = send_sms(params[:sms][:to], params[:sms][:body])
    Sms.create(sms)
    redirect_to users_path
  end

  def send_welcome_message
    msg = "Hey #{current_user.first_name}! Each morning, on days you’re not unavailable, the system will shoot you a text asking if you’re free to grab lunch with a member of the group. You simply respond “yes” or “no”. If yes, and we see a match, we’ll pair you up in a Groupme so you two can pick the place. That’s it!

Stoked to have you as part of the Free at Noon group. See ya soon!"
    send_sms(current_user.phone_number, msg)
    render json: { result: "success" }
  end

  def twiml
    Sms.create({from: params[:From].sub("+1",""),
                 to: params[:To].sub("+1",""),
                 body: params[:body]})
    render xml: Twilio::TwiML::Response.new.text
  end

  def send_sms(to, body)
    sms = { from: "+12679152717", to: "+1#{to.tr('() -','')}", body: body }
    twilio_client.account.messages.create(sms)
    sms
  end

  def twilio_client
    @client ||= Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
  end
end
