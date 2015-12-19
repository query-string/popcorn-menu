class MovieLink < ActiveRecord::Base
  belongs_to :movie
  scope :from_engine, ->(name) { where("engine = ?", name) }
  scope :engine_movie_ids, ->(name) { from_engine(name).map(&:movie_id).uniq }

  def self.engines
    all.pluck(:engine).uniq.sort
  end
end
