namespace :db do

  desc "Create User accounts. NOTE: You need to escape the [] brackets with \\ to make this work with bundle exec"
  task :create_users, [:file] => :environment do |t, args| 
    puts "Creating Users:"
    emails = IO.readlines(args[:file]).each {|x| x.strip!; puts x }
    emails.each do |x|
      u = User.create!(:email => x, :name => x, :authentication_token => (Digest::SHA1.hexdigest([Time.now, rand].join)) )
      u.send_reset_password_instructions
    end
    puts "Users Created! Whoop!"
  end

end
