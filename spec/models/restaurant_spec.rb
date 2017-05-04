require 'rails_helper'

describe Restaurant, type: :model do

  it { is_expected.to belong_to(:user) }

  it 'is not valid with a name of less than 3 characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    Restaurant.create(name: 'Beatties', user: User.new)
    restaurant = Restaurant.new(name: 'Beatties')
    expect(restaurant).to have(1).error_on(:name)
  end

  describe '#average rating' do
    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        restaurant = Restaurant.create(name: 'The Ivy', user: User.new)
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end
    context 'one review' do
      it 'returns that rating' do
        restaurant = Restaurant.create(name: 'The Ivy', user: User.new)
        restaurant.reviews.create(rating: 4, user: User.new)
        expect(restaurant.average_rating).to eq 4
      end
    end
    context 'multiple reviews' do
      it 'returns that rating' do
        restaurant = Restaurant.create(name: 'The Ivy', user: User.new)
        restaurant.reviews.create(rating: 1, user: User.new)
        restaurant.reviews.create(rating: 3, user: User.new)
        # expect(restaurant.average_rating).to eq 2
      end
    end
  end

end
