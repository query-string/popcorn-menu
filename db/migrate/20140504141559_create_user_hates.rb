class CreateUserHates < ActiveRecord::Migration
  def change
    create_table :user_hates, id: false do |t|
      t.references :user, index: true
      t.references :movie, index: true

      t.timestamps
    end
  end
end
