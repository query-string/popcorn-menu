class User < ActiveRecord::Base

  has_many :user_waits
  has_many :user_hates

end
