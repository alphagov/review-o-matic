namespace :db do

  desc "Finds or creates user accounts and emails all users in provided list with login instructions."
  task :create_users, [:file] => :environment do |t, args| 
    puts "Creating Users:"
    File.readlines(args[:file]).each do | email |
    	email.chomp!
    	name = email

    	if email =~ /^(\w+)\..+@/
    		name = $1.capitalize
    	end

			begin
				u = User.create!(:email => email, :name => name, :authentication_token => (Digest::SHA1.hexdigest([Time.now, rand].join)) )
			rescue Mongoid::Errors::Validations => e
				if e.message == "Validation failed - Email is already taken."
					u = User.first(conditions: {:email => email})
				else
					raise
				end
			end

			u.send_reset_password_instructions
  		puts "Sent email to #{email}"
    end
    puts "Users Created! Whoop!"
  end

end
