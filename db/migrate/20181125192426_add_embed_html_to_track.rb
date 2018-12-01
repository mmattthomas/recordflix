class AddEmbedHtmlToTrack < ActiveRecord::Migration[5.1]
  def change
    add_column :tracks, :embed_html, :string
  end
end
