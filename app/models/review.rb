class Review < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :restaurant
  has_many :restaurants, through: :reviews, source: :restaurant
  validates :rating, inclusion: (1..5)
end
