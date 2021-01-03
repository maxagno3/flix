class Movie < ApplicationRecord

  has_many :reviews
  has_many :favs, dependent: :destroy
  has_many :likers, through: :favs, source: :user
  has_many :categorizations, dependent: :destroy
  has_many :genres, through: :categorizations

  validates :name, :released_at ,presence: true

  validates :description, length: {minimum: 25}

  # validates :rating, numericality: {only_integer: true}

  validates :poster_image, format: {with: /\w+\.(jpg|png)\z/i, message: "must be an JPG or PNG image"}

  def self.upcoming
    where("released_at > ?", Date.new.strftime("%d %B %Y")).order("released_at")
  end

  def unavailable?
    rating.blank? || rating.zero?
  end
end
