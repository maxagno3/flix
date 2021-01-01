class Review < ApplicationRecord
  belongs_to :movie

  validates :name, presence: true

  validates :review, length: {minimum: 10}
end
