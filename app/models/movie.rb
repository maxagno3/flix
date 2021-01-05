class Movie < ApplicationRecord

  before_save :set_slug

  has_many :reviews
  has_many :favs, dependent: :destroy
  has_many :likers, through: :favs, source: :user
  has_many :categorizations, dependent: :destroy
  has_many :genres, through: :categorizations

  validates :name, :released_at ,presence: true

  validates :description, length: {minimum: 25}

  # validates :rating, numericality: {only_integer: true}

  validates :poster_image, format: {with: /\w+\.(jpg|png)\z/i, message: "must be an JPG or PNG image"}

  scope :upcoming, -> { where("released_at > ?", Time.new).order("released_at") }

  scope :past, -> { where("released_at < ?", Time.new).order("released_at") }

  scope :flop, ->(max=0.34e1) { where(rating:max) }

  scope :hit, ->(max=0.9e1) { limit(max) }

  def unavailable?
    rating.blank? || rating.zero?
  end

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = name.parameterize
  end

end
