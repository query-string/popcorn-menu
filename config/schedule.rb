job_type :rakeubuntu, 'cd :path && RAILS_ENV=production bundle exec rake :task :output'

set :job_template, "/bin/bash -l -c ':job'"

every 1.day, at: '07:00 am' do
  rakeubuntu 'movies:import'
end