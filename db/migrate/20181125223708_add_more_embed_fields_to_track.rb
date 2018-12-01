class AddMoreEmbedFieldsToTrack < ActiveRecord::Migration[5.1]
  def change
    add_column :tracks, :thumbnail, :string
    add_column :tracks, :original_author, :string
    add_column :tracks, :embed_type, :string
    add_column :tracks, :length_in_seconds, :string
  end
end
