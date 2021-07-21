require 'rails_helper'

RSpec.describe 'Adopt Application Show Page' do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Longmont Humane Society', city: 'Longmont, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(name: 'Butter', breed: 'Cocker Spaniel', age: 11, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: 'Marg', breed: 'Beagle', age: 3, adoptable: false)
    @pet_3 = @shelter_1.pets.create!(name: 'Mathias', breed: 'Great Dane', age: 3, adoptable: true)
    @pet_4 = @shelter_1.pets.create!(name: 'Butters', breed: 'Pitbull', age: 2, adoptable: true)

    @app_1 = @pet_1.adopt_applications.create!(
      first_name: "Sean",
      last_name: "King",
      street_address: "1000 Dinosaur Lane",
      city: "Longmont",
      state: "CO",
      zipcode: 80504)

    ApplicationPet.create!(pet: @pet_3, adopt_application: @app_1)

    @app_2 = @pet_4.adopt_applications.create!(
      first_name: "Trevor",
      last_name: "Bennet",
      street_address: "3200 Nuclear Lane",
      city: "Balston Spa",
      state: "NY",
      zipcode: 10887)
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
    expect(page).to have_content("Why do you think you'd be a good home for this pet(s)?")
    expect(page).to have_content(@app_1.status)

    expect(page).to_not have_content(@app_2.first_name)
    expect(page).to_not have_content(@app_2.last_name)
    expect(page).to_not have_content(@app_2.street_address)
    expect(page).to_not have_content(@app_2.city)
    expect(page).to_not have_content(@app_2.state)
    expect(page).to_not have_content(@app_2.zipcode)
    expect(page).to_not have_content(@pet_4.name)

    click_on("#{@pet_1.name}")

    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end

  # Searching for Pets for an Application
  # As a visitor
  # When I visit an application's show page
  # And that application has not been submitted,
  # Then I see a section on the page to "Add a Pet to this Application"
  # In that section I see an input where I can search for Pets by name
  # When I fill in this field with a Pet's name
  # And I click submit,
  # Then I am taken back to the application show page
  # And under the search bar I see any Pet whose name matches my search
  it 'has a text box to filter results by name' do
    app_3 = AdoptApplication.create!(
      first_name: "Trevor",
      last_name: "Bennet",
      street_address: "3200 Nuclear Lane",
      city: "Balston Spa",
      state: "NY",
      zipcode: 10887)

    visit "/adopt_applications/#{app_3.id}"

    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_button("Search")
  end

  it 'can search for pets by name and return list of pets that match name' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
    pet_4 = Pet.create(adoptable: true, age: 1, breed: 'chihuahua', name: 'Babe', shelter_id: shelter.id)

    app_3 = AdoptApplication.create!(
      first_name: "Trevor",
      last_name: "Bennet",
      street_address: "3200 Nuclear Lane",
      city: "Balston Spa",
      state: "NY",
      zipcode: 10887)

    visit "/adopt_applications/#{app_3.id}"

    within "#Pet-Search" do
      fill_in('Pet Name:', with: 'Babe')
      click_on('Search')

      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_4.name)
      expect(page).to_not have_content(pet_1.name)
      expect(page).to_not have_content(pet_3.name)
    end

    # fill_in('Pet Name:', with: 'Babe')
    # click_on('Search')

    # expect(page).to have_content(pet_2.name)
    # expect(page).to have_content(pet_4.name)
    # expect(page).to_not have_content(pet_1.name)
    # expect(page).to_not have_content(pet_3.name)
  end

  # Add a Pet to an Application
  # As a visitor
  # When I visit an application's show page
  # And I search for a Pet by name
  # And I see the names Pets that match my search
  # Then next to each Pet's name I see a button to "Adopt this Pet"
  # When I click one of these buttons
  # Then I am taken back to the application show page
  # And I see the Pet I want to adopt listed on this application
  it 'can add pets to the application' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

    app_3 = AdoptApplication.create!(
      first_name: "Trevor",
      last_name: "Bennet",
      street_address: "3200 Nuclear Lane",
      city: "Balston Spa",
      state: "NY",
      zipcode: 10887)

    visit "/adopt_applications/#{app_3.id}"

    fill_in('Pet Name:', with: 'Babe')
    click_on('Search')

    within "#Pet-Match-#{pet_2.name}" do
      expect(page).to have_content(pet_2.name)
      expect(page).to have_button('Adopt this Pet')
    end

    click_on('Adopt this Pet')

    expect(page).to have_link(pet_2.name)
  end
end
