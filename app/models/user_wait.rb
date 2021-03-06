class UserWait < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
  validates :movie_id, uniqueness: {scope: :user_id}

   def self.default_scope
    order('user_waits.created_at DESC')
  end
end
