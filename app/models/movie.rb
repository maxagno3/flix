class Movie < ApplicationRecord
  def unavailable?
    rating.blank? || rating.zero?
  end
end
