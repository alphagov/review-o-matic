namespace :log do

  desc "Generate a list of reviewed mapping log entries that do not match a review in Review-O-Matic. Expects a file in db/nginx_list.txt that contains Nginx log entries. Outputs to reviewed_mappings_output.txt"
  task :generate_mapping_log_list => :environment do
    reviews = Review.all

    mappings = {}
    reviews.each do |review| 
      if mappings[review.mapping.mapping_id]
        mappings[review.mapping.mapping_id] << review.mapping
      else
        mappings[review.mapping.mapping_id] = [review.mapping]
      end 
    end

    nginx_list = IO.readlines("#{Rails.root}/db/nginx_list.txt")
    nginx_list.uniq!
    nginx_mappings = {}

    nginx_list.each do |x| 
      y = x.match(/__\/reviews\/([a-z0-9]+)/)
      if y && y[1] != "undefined"
        if nginx_mappings[y[1]]
          nginx_mappings[y[1]] << x
        else
          nginx_mappings[y[1]] = [x]
        end
      end
    end

    puts "Reviews Hash"
    counter = 0
    mappings.each do |x,y| 
      # To see the actual mapping ids and count...
      #puts "#{x} COUNT: #{y.count}"
      counter += y.count 
    end
    puts "Record Count: #{counter}"
    puts

    puts "NginX Hash"
    counter = 0
    nginx_mappings.each do |x,y| 
      # To see the actual mapping ids and count...
      #puts "#{x} COUNT: #{y.count}" 
      counter += y.count 
    end
    puts "Record Count: #{counter}"
    puts

    puts "Sorted Hash"
    counter = 0
    output = []
    nginx_mappings.each do |key,value| 
      if mappings[key]
        (mappings[key].count).times do
          value.shift
        end
      end
      counter += value.count
      # To see the actual mapping ids and count...
      #puts "#{key} COUNT: #{value.count}"
      value.each do |x|
        output << x
      end
    end
    puts "Record Count: #{counter}"
    puts
    File.open("#{Rails.root}/db/reviewed_mappings_output.txt", "w") do |file|
      file.puts output
    end


  end

end
