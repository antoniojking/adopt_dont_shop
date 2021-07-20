# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ApplicationPet.destroy_all
Shelter.destroy_all
Pet.destroy_all
AdoptApplication.destroy_all

# Shelters
@shelter_1 = Shelter.create!(name: 'Longmont Humane Society', city: 'Longmont, CO', foster_program: false, rank: 8)
@shelter_2 = Shelter.create!(name: 'Boulder Humane Society', city: 'Boulder, CO', foster_program: true, rank: 9)
@shelter_3 = Shelter.create!(name: 'Lyons Humane Society', city: 'Lyons, CO', foster_program: false, rank: 6)

# Pets associated with a Shelter
@pet_1 = @shelter_1.pets.create!(name: 'Butter', breed: 'Cocker Spaniel', age: 11, adoptable: true)
@pet_2 = @shelter_1.pets.create!(name: 'Marg', breed: 'Beagle', age: 3, adoptable: false)
@pet_3 = @shelter_1.pets.create!(name: 'Mathias', breed: 'Great Dane', age: 6, adoptable: true)
@pet_4 = @shelter_2.pets.create!(name: 'Amigo', breed: 'Australian Shephard', age: 5, adoptable: true)
@pet_5 = @shelter_2.pets.create!(name: 'Valor', breed: 'Husky', age: 8, adoptable: true)
@pet_6 = @shelter_3.pets.create!(name: 'Eugene', breed: 'Golden Doodle', age: 1, adoptable: true)

# Applications associted with a Pet
@app_1 = @pet_1.adopt_applications.create!(
  first_name: "Sean",
  last_name: "King",
  street_address: "1000 Dinosaur Lane",
  city: "Longmont",
  state: "CO",
  zipcode: 80504,
  description: "I would make a good home for this pet because my dad will take care of it for me.")
@app_2 = @pet_4.adopt_applications.create!(
  first_name: "Trevor",
  last_name: "King",
  street_address: "2000 Marble Lane",
  city: "Longmont",
  state: "CO",
  zipcode: 80504,
  description: "I would make a good home for this pet because I love marbles and my dog will too.")

# Pets added to Applications through Join
ApplicationPet.create!(pet: @pet_3, adopt_application: @app_1)
