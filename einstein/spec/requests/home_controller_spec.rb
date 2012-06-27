require 'spec_helper'

describe 'home page' do
  it 'is accessible' do
    visit '/'
    page.should have_content('Einstein')
  end
end