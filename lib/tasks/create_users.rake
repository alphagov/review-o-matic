namespace :db do

  desc "Create User accounts. NOTE: You need to escape the [] brackets with \\ to make this work with bundle exec"
  task :create_users, [:file] => :environment do |t, args| 
    puts "Creating Users:"
    emails = IO.readlines(args[:file]).each {|x| x.strip! }
    emails.each do |x|
    	name = x
    	first_part_of_email = $1 if x =~ /^(\w+)\..+@/
    	if first_part_of_email.nil?
    		name = x
    	else 
    		name = first_part_of_email.capitalize
		end

		u = User.where(email: x).first  
		unless u 
			u = User.create!(:email => x, :name => name, :authentication_token => (Digest::SHA1.hexdigest([Time.now, rand].join)) )
		end
  		u.send_reset_password_instructions
  		puts "Sent email to #{x}"
    end
    puts "Users Created! Whoop!"
  end

end
