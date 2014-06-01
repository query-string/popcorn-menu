job_type :rakeubuntu, 'cd :path && RAILS_ENV=production bundle exec rake :task :output'

set :job_template, "/bin/bash -l -c ':job'"

every 1.hour do
  rakeubuntu 'movies:import'
end
