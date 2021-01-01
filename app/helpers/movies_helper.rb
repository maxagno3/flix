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
end
