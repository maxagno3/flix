class Movie < ApplicationRecord

  before_save :set_slug

  has_many :reviews
  has_many :favs, dependent: :destroy
  has_many :likers, through: :favs, source: :user
  has_many :categorizations, dependent: :destroy
  has_many :genres, through: :categorizations

  has_one_attached :main_image

  validates :name, :released_at ,presence: true

  validates :description, length: {minimum: 25}

  validate :acceptable_image

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

  def acceptable_image
    return unless main_image.attached?

    unless main_image.blob.byte_size <= 1.megabyte
      errors.add(:main_image, "is too big.")
    end

    acceptable_image_formats = ["image/jpeg", "image/png"]

    unless acceptable_image_formats.include?(main_image.content_type)
      errors.add(:main_image, "must be JPEG or PNG")
    end
  end

  def set_slug
    self.slug = name.parameterize
  end

end
