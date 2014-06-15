class User < ActiveRecord::Base

  devise :database_authenticatable, :trackable, :omniauthable, omniauth_providers: [:facebook]

  has_many :user_waits
  has_many :waits, through: :user_waits, source: :movie
  has_many :user_hates
  has_many :hates, through: :user_hates, source: :movie
  has_many :user_watches
  has_many :watches, through: :user_watches, source: :movie

  def unmarked
    if waits.size > 0 || hates.size > 0 || watches.size > 0
      marked = %w(waits hates watches).inject([]){|marked, scope| marked.concat self.instance_eval("#{scope}.pluck(:movie_id)")}
      Movie.excepting(marked)
    else
      Movie.all
    end
  end

end
