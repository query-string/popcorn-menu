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

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      #user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
    end
  end

end
