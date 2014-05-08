task :reset_midnight => :environment do
  User.all.each do |u|
    u.response = nil
    u.save
  end
end
