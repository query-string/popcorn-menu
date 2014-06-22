class Movie < ActiveRecord::Base

  has_many :movie_links
  has_many :user_waits
  has_many :users_pending, through: :user_waits, source: :user
  has_many :user_hates
  has_many :users_hating, through: :user_hates, source: :user
  has_many :user_watches
  has_many :users_watching, through: :user_watches, source: :user

  has_attached_file :cover,
                    styles: {normal: '140x210#'},
                    url: '/uploads/movies/covers/:id_partition/:attachment_:style.:extension',
                    path: ':rails_root/public/uploads/movies/covers/:id_partition/:attachment_:style.:extension'
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  def self.import
    current = self.pluck(:name)
    import = Popcorn.new(output_name: :international_name).get_all(group_similar: true, per_engine_movies: 20)
    import_except_current = import.reject{|movie| current.include? movie.name}
    import_except_current.each do |movie|
      object = self.create(name: movie.name, international_name: movie.international_name, cover: movie.cover)
      movie.links.each do |engine, link|
        object.movie_links.create(engine: engine, link: link)
      end
    end
  end

  scope :excepting, ->(marked) { where('id NOT IN (?)', marked) }
  scope :by_date, -> { order('created_at DESC') }

end
