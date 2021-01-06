module MoviesHelper
  def format_rating(movie)
    if movie.unavailable?
      "N/A"
    else
      movie.rating
    end
  end

  def format_date(movie)
    movie.released_at.strftime("%d %B %Y")
  end

  def main_image(movie)
    if movie.main_image.attached?
      image_tag movie.main_image.variant(resize_to_limit: [75, 75])
    else
      image_tag "placeholder"
    end
  end
end
