class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :description
      t.integer :rating
      t.integer :runtime
      t.date :released
      t.string :url
      t.integer :checked_out_to_id

      t.timestamps
    end
  end
end
