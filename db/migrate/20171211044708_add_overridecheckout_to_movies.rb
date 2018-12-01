class AddOverridecheckoutToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :override_checkout, :string
  end
end
