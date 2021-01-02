class Fav < ApplicationRecord
  belongs_to :movie
  belongs_to :user
end
