desc "Remove guest accounts more than a week old."
task :guest_cleanup => :environment do
  User.where("updated_at < ?", 1.day.ago).where(guest: true).destroy_all
end
