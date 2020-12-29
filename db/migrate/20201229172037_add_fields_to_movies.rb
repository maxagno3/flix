class AddFieldsToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :genre, :string
    add_column :movies, :released_at, :datetime
  end
end
