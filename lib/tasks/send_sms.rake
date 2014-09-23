# -*- coding: utf-8 -*-
task :ask_morning => :environment do
  users = User.all
  twilio = TwilioClient.new

  day_today = Time.now.wday
  users.each do |u|
    if u.available_day?(day_today) && !u.mute
      begin
        twilio.send_morning_sms(u)
        puts "msg sent to: " + u.full_name
      rescue
        puts "FAILED sending to: " + u.full_name
      end
    end
  end
end

task :msg_hong => :environment do
  TwilioClient.new.send_sms("+12155880230","A TALE OF TWO CITIES")
  puts "message sent to hong"
end

task :msg_hunter => :environment do
  TwilioClient.new.send_sms("+16502913866","A TALE OF TWO CITIES")
  puts "message sent to hunter"
end
