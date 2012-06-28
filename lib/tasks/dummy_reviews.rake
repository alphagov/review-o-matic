namespace :db do

  desc "Create dummy reviews"
  task :dummy_reviews => :environment do

  end

  desc "Import Migratorator Production DB"
  task :import_migratorator_data do
    `mongorestore #{RAILS.root}/db/migratorator_production_db_dump` 
  end


  
end
