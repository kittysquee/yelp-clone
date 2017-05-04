require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'KFC', user: User.new }

  scenario 'allows user to leave review using form' do
    visit restaurants_path
    sign_up('kate@kate.com')
    click_link 'Review KFC'
    fill_in "Thoughts", with: "stinkin"
    select '1', from: 'Rating'
    click_button 'Leave Review'
    click_link('KFC')
    expect(page).to have_content 'stinkin'
  end

  scenario 'user cannot leave review for restaurant they already reviewed' do
    visit restaurants_path
    sign_up('kate@kate.com')
    click_link 'Review KFC'
    fill_in "Thoughts", with: "stinkin"
    select '1', from: 'Rating'
    click_button 'Leave Review'
    visit restaurants_path
    expect(page).not_to have_link('Review KFC')
  end

  scenario 'user cannot review their own restaurant' do
    visit restaurants_path
    sign_up('kate@kate.com')
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'Kates'
    click_button 'Create Restaurant'
    expect(current_path).to eq restaurants_path
    expect(page).not_to have_content('Review Kates')
  end

  scenario 'displays an average rating for all reviews' do
    visit restaurants_path
    sign_up('kate@kate.com')
    leave_review('whatever', '1')
    click_link 'Sign out'
    sign_up('elaine@elaine.com')
    leave_review('i am a crazy person secondary to malnourishment', '5')
    expect(page).to have_content('Average rating: 3')
  end
end
