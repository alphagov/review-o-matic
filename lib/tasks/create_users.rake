namespace :db do

  desc "Create User accounts. NOTE: You need to escape the [] brackets with \\ to make this work with bundle exec"
  task :create_users, [:file] => :environment do |t, args| 
    puts "Creating Users:"
    emails = IO.readlines(args[:file]).each {|x| x.strip! }
    emails.each do |x|
    	begin
	    	first_part_of_email = $1 if x =~ /^(\w+)\..+@/
	    	if first_part_of_email.nil?
	    		name = x
	    	else 
	    		name = first_part_of_email.capitalize
    		end
    		u = User.create!(:email => x, :name => name, :authentication_token => (Digest::SHA1.hexdigest([Time.now, rand].join)) )
      		u.send_reset_password_instructions
    	end
    end
    puts "Users Created! Whoop!"
  end

end
