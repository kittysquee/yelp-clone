def sign_up
  click_link 'Sign up'
  fill_in 'Email', with: 'drdre@chronic.org'
  fill_in 'Password', with: 'iamhigh'
  fill_in 'Password confirmation', with: 'iamhigh'
  click_button 'Sign up'
end
