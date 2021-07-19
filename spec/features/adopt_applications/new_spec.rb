require 'rails_helper'

RSpec.describe 'Adopt Application New Page' do
  # As a visitor
  # When I visit the pet index page (see /pets/index_spec.rb)
  # Then I see a link to "Start an Application"
  # When I click this link
  # Then I am taken to the new application page where I see a form
  # When I fill in this form with my:
  #   - Name
  #   - Street Address
  #   - City
  #   - State
  #   - Zip Code
  # And I click submit
  # Then I am taken to the new application's show page
  # And I see my Name, address information, and description of why I would make a good home
  # And I see an indicator that this application is "In Progress"
  it 'has a form to fill out attributes' do
    app = AdoptApplication.create!(
      first_name: "Sean",
      last_name: "King",
      street_address: "1000 Dinosaur Lane",
      city: "Longmont",
      state: "CO",
      zipcode: 80504,
      description: "I would make a good home for this pet because my dad will take care of it for me.",
      application_status: "In Progress")

    visit '/adopt_applications/new'

    fill_in('First Name:', with: app.first_name)
    fill_in('Last Name:', with: app.last_name)
    fill_in('Street Address:', with: app.street_address)
    fill_in('City:', with: app.city)
    fill_in('State:', with: app.state)
    fill_in('Zipcode:', with: app.zipcode)
    fill_in(:description, with: app.description)

    click_on('Submit Application')

    expect(current_path).to eq("/adopt_applications/#{app.id}")
    expect(page).to have_content(app.first_name)
    expect(page).to have_content(app.last_name)
    expect(page).to have_content(app.street_address)
    expect(page).to have_content(app.city)
    expect(page).to have_content(app.state)
    expect(page).to have_content(app.zipcode)
    expect(page).to have_content(app.description)
  end
end
