# -*- coding: utf-8 -*-
task :ask_morning => :environment do
  users = User.all
  twilio = TwilioClient.new

  users.each do |u|
    unless u.bad_dates_set.include?(Time.now.to_date)
      msg = "Good morning #{u.first_name}! Up for having lunch with someone today? (Please respond “yes” or “no”.)"
      twilio.send_sms(u.phone_number,msg)
      puts "msg sent to: " + u.full_name
    end
  end
end

task :ask_noon => :environment do
  users = User.where(response: nil)
  twilio = TwilioClient.new

  users.each do |u|
    unless u.bad_dates_set.include?(Time.now.to_date)
      msg = "Hey there #{u.first_name}! We haven’t heard back about lunch today. Please let us know in the next 30 minutes. (Please respond “yes” or “no”.)"
      twilio.send_sms(u.phone_number,msg)
      puts "msg sent to: " + u.full_name
    end
  end
end
