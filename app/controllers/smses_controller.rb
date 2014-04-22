class SmsesController < ApplicationController
  def create
    @client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
    to = "+1#{params[:sms][:to].tr('() -','')}"
    sms = { from: "+12679152717", to: to, body: params[:sms][:body] }
    @client.account.messages.create(sms)
    Sms.create(sms)
    redirect_to users_path
  end
end
