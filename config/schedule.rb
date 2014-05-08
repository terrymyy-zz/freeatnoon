env :PATH, ENV['PATH']

set :output, "cronlog.log"
set :environment, "development"

every 1.day, at: "8:00 am" do
  rake "ask_morning"
end

every 1.day, at: "10:30 am" do
  rake "ask_noon"
end

every 1.day, at: "00:00 am" do
  rake "reset_midnight"
end

# Testing purposes
# every 1.day, at: "5:00 pm" do
#   rake "msg_hong"
# end
