class CreateTrackLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :track_likes do |t|
      t.references :user, foreign_key: {to_table: :users}
      t.references :track, foreign_key: {to_table: :tracks}

      t.timestamps
    end
  end
end
