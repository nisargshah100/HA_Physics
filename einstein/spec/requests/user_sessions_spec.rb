require 'spec_helper'

describe 'User login is' do
  let!(:user) { Fabricate(:user) }

  it 'successful' do
    visit new_user_session_path
    fill_in 'email', :with => user.email
    fill_in 'password', :with => 'asdasd'

    click_button 'Sign In'
    page.should have_content('Logout')
  end

  it 'is invalid' do
    visit new_user_session_path
    fill_in 'email', :with => user.email
    fill_in 'password', :with => 'asdas'

    click_button 'Sign In'
    page.should have_content('Login')
  end
end