require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'KFC', user: User.new }

  scenario 'allows user to leave review using form' do
    visit restaurants_path
    sign_up
    click_link 'Review KFC'
    fill_in "Thoughts", with: "stinkin"
    select '1', from: 'Rating'
    click_button 'Leave Review'
    click_link('KFC')
    expect(page).to have_content 'stinkin'
  end

  scenario 'user cannot leave review for restaurant they already reviewed' do
    visit restaurants_path
    sign_up
    click_link 'Review KFC'
    fill_in "Thoughts", with: "stinkin"
    select '1', from: 'Rating'
    click_button 'Leave Review'
    visit restaurants_path
    expect(page).not_to have_link('Review KFC')
  end
end
