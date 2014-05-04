class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.string :international_name
      t.attachment :cover

      t.timestamps
    end
    add_index :movies, :name
  end
end
