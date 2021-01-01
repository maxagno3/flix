class AddImageToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :poster_image, :string, default: "logo.png"
  end
end
