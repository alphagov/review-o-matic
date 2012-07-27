namespace :db do

  desc "Finds or creates user accounts and emails all users in provided list with login instructions."
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

			begin
				u = User.create!(:email => x, :name => name, :authentication_token => (Digest::SHA1.hexdigest([Time.now, rand].join)) )
			rescue Mongoid::Errors::Validations => e
				puts "we are here and e message is #{e.message}"
				if e.message == "Validation failed - Email is already taken."
					u = User.first(conditions: {:email => x})
				else
					raise
				end
			end

			u.send_reset_password_instructions
  		puts "Sent email to #{x}"
    end
    puts "Users Created! Whoop!"
  end

end
