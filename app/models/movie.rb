class Movie < ActiveRecord::Base

  has_attached_file :cover,
                    styles: {normal: '140x210#'},
                    url: '/uploads/movies/covers/:id_partition/:attachment_:style.:extension',
                    path: ':rails_root/public/uploads/movies/covers/:id_partition/:attachment_:style.:extension'
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  def self.import
    current = self.pluck(:name)
    import = Popcorn.new(group_by_name: true, output_name: :international_name).get_all
    import_except_current = import.reject{|movie| current.include? movie.name}
    import_except_current.each do |movie|
      self.create(name: movie.name, international_name: movie.international_name, cover: movie.cover)
    end
  end

end
