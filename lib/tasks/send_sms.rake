# -*- coding: utf-8 -*-
task :ask_morning => :environment do
  users = User.all
  twilio = TwilioClient.new

  users.each do |u|
    unless u.bad_dates_set.include?(Time.now.to_date) || u.mute
      begin
        twilio.send_morning_sms(u)
        puts "msg sent to: " + u.full_name
      rescue
        puts "FAILED sending to: " + u.full_name
      end
    end
  end
end

task :ask_noon => :environment do
  users = User.where(response: nil)
  twilio = TwilioClient.new

  users.each do |u|
    unless u.bad_dates_set.include?(Time.now.to_date) || u.mute
      begin
        twilio.send_noon_sms(u)
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

