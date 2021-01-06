class RemoveImageFileNameFromMovies < ActiveRecord::Migration[6.0]
  def change
    remove_column :movies, :poster_image, :string
  end
end
