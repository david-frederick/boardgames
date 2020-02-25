namespace :sync do
  desc 'Retrieve my BGG collection and upsert into Game records'
  task collection: :environment do
    BggService.new.sync_collection_data
  end
end
