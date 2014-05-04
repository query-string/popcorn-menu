class User < ActiveRecord::Base

  has_many :user_waits
  has_many :user_hates
  has_many :user_watches

end
