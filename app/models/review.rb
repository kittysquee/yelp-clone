class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  
  validates :rating, inclusion: (1..5)
  validates :user, uniqueness: {
    message: "has reviewed this restaurant already",
    scope: :restaurant
  }
end
