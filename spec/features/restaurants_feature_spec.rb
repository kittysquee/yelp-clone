require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit restaurants_path
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC', user: User.new)
    end

    scenario 'display restaurants' do
      visit restaurants_path
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out form, then displays restaurant' do
      visit restaurants_path
      sign_up('kate@kate.com')
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq restaurants_path
    end

    context 'an invalid restaurant' do
      scenario 'does not let user submit name that is too short' do
        visit restaurants_path
        sign_up('kate@kate.com')
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing restaurants' do

    let!(:kfc){Restaurant.create(name:'KFC', user: User.new)}

    scenario 'lets a user view a restaurant' do
      visit restaurants_path
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq restaurant_path(kfc)
    end
  end

  context 'editing restaurants' do
    scenario 'lets user edit restaurant' do
      visit restaurants_path
      sign_up('kate@kate.com')
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      click_link 'Kentucky Fried Chicken'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Deep fried goodness'
    end

    scenario 'only user who made restaurant can delete it' do
      visit restaurants_path
      sign_up('kate@kate.com')
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link 'Sign out'
      click_link 'Sign up'
      fill_in 'Email', with: 'cat@cat.com'
      fill_in 'Password', with: 'catcat'
      fill_in 'Password confirmation', with: 'catcat'
      click_button 'Sign up'
      expect(page).to_not have_content 'Edit KFC'
    end
  end

  context 'deleting restaurants' do

    scenario 'removes restaurant when user clicks delete link' do
      visit restaurants_path
      sign_up('kate@kate.com')
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'only user who made restaurant can delete it' do
      visit restaurants_path
      sign_up('kate@kate.com')
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      click_link 'Sign out'
      click_link 'Sign up'
      fill_in 'Email', with: 'cat@cat.com'
      fill_in 'Password', with: 'catcat'
      fill_in 'Password confirmation', with: 'catcat'
      click_button 'Sign up'
      expect(page).to_not have_content 'Delete KFC'
    end
  end
end
