class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favs, dependent: :destroy
  has_many :movie_likers, through: :favs, source: :movie

  has_secure_password

  validates :name, presence: true
  validates :email, format: {with: /\S+@\S+/}, uniqueness: {case_sensitive: false}
end
