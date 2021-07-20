require 'rails_helper'

RSpec.describe 'Adopt Application Show Page' do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Longmont Humane Society', city: 'Longmont, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(name: 'Butter', breed: 'Cocker Spaniel', age: 11, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: 'Marg', breed: 'Beagle', age: 3, adoptable: false)
    @pet_3 = @shelter_1.pets.create!(name: 'Mathias', breed: 'Great Dane', age: 3, adoptable: true)

    @app_1 = @pet_1.adopt_applications.create!(
      first_name: "Sean",
      last_name: "King",
      street_address: "1000 Dinosaur Lane",
      city: "Longmont",
      state: "CO",
      zipcode: 80504,
      description: "I would make a good home for this pet because my dad will take care of it for me.")

    ApplicationPet.create!(pet: @pet_3, adopt_application: @app_1)
  end

  # As a visitor
  # When I visit an applications show page
  # Then I can see the following:
  # - Name of the Applicant
  # - Full Address of the Applicant including street address, city, state, and zip code
  # - Description of why the applicant says they'd be a good home for this pet(s)
  # - names of all pets that this application is for (all names of pets should be links to their show page)
  # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
  it 'shows the application and all its attributes' do
    visit "/adopt_applications/#{@app_1.id}"
    # save_and_open_page
    expect(page).to have_content(@app_1.first_name)
    expect(page).to have_content(@app_1.last_name)
    expect(page).to have_content(@app_1.street_address)
    expect(page).to have_content(@app_1.city)
    expect(page).to have_content(@app_1.state)
    expect(page).to have_content(@app_1.zipcode)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_3.name)
    expect(page).to have_content(@app_1.description)
    expect(page).to have_content(@app_1.status)

    click_on("#{@pet_1.name}")

    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end
end
