class MovieLink < ActiveRecord::Base
  belongs_to :movie

  def self.engines
    all.pluck(:engine).uniq.sort
  end
end
