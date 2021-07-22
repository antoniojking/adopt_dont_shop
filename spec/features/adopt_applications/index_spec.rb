require 'rails_helper'

RSpec.describe 'Adopt Application Index Page' do
  before :each do

  end

  it 'has an index page' do
    visit '/adopt_applications'

    expect(page).to have_content('Adopt Application Index Page')
  end
end
