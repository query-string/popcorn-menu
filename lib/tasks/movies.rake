namespace :movies do

  task :import => :environment  do
    Movie.import
  end

end