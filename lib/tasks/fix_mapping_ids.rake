namespace :db do

  desc "Fixes mapping.mapping_id in batches. Expects to be passed a whitespace separated list of invalid mapping ids and a whitespace separated list of correct mapping ids. These lists are converted to arrays. The two arrays must match in number. NOTE! To pass args using Bundle exec you must escape square brackets like so: bundle exec rake db:fix_mapping_ids\['old_id_1 old_id_2','new_id_1 new_id_2'\]"
  task :fix_mapping_ids, [:incorrect_mapping_ids, :mapping_ids] => :environment do |t, args|
    incorrect_mapping_ids = args[:incorrect_mapping_ids].split(' ') 
    mapping_ids = args[:mapping_ids].split(' ')
    if incorrect_mapping_ids.count == mapping_ids.count
      puts "Processing mappings..."
      incorrect_mapping_ids.each do |id|
        begin
          mapping = Mapping.first(conditions: {mapping_id: id})
          puts "Old id: #{id}"
          mapping.mapping_id = mapping_ids[incorrect_mapping_ids.index(id)]
          puts "New id: #{mapping.mapping_id}"
          mapping.save!
        rescue
          puts "A mapping with the id #{id} was not found or could not be saved."
        end
      end
    else
      puts "The incorrect_mapping_ids array and the mapping_ids array must be equal in number"
    end
  end

end
