class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :review, length: {minimum: 10}
end
