namespace :db do

  desc "Finds or creates user accounts and emails all users in provided list with login instructions."
  task :create_users, [:file] => :environment do |t, args| 
    puts "Creating Users:"
    
		unsuccessful_attempts = []
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

      begin
        u.send_reset_password_instructions
        puts "Sent email to #{email}"
      rescue
        unsuccessful_attempts.push(email)
      end

    end
    puts "Script completed successfully."
    puts "Users not created:"
    unsuccessful_attempts.each { |failure| puts failure }
  end

end
