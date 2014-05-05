class User < ActiveRecord::Base

  has_many :user_waits
  has_many :waits, through: :user_waits, source: :movie
  has_many :user_hates
  has_many :hates, through: :user_hates, source: :movie
  has_many :user_watches
  has_many :watches, through: :user_watches, source: :movie

end
