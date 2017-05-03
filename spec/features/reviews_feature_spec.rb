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
end
