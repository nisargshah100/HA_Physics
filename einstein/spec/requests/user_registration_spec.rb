require 'spec_helper'

describe 'User registration is' do
  before(:each) do
    visit new_user_registration_path
  end

  it 'successful' do
    create_user()

    click_button 'Create Account'
    page.should have_content('Logout')
  end

  it 'disallowed with invalid email' do
    create_user()
    fill_in 'email', :with => 'a@a'

    click_button 'Create Account'
    page.should have_content('invalid')
  end
end

def create_user
  fill_in 'email', :with => 'test@test.com'
  fill_in 'password', :with => 'testing'
  fill_in 'confirm_password', :with => 'testing'
end