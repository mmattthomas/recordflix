class CreateTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks do |t|
      t.string :title
      t.string :description
      t.integer :likes
      t.integer :comments
      t.string :url
      t.references :posted_by, foreign_key: {to_table: :users}
      t.references :team, foreign_key: {to_table: :teams}

      t.timestamps
    end
  end
end
