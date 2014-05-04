class CreateMovieLinks < ActiveRecord::Migration
  def change
    create_table :movie_links do |t|
      t.string :link
      t.string :engine
      t.references :movie, index: true

      t.timestamps
    end
  end
end
