class CreateAdoptApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :adopt_applications do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zipcode
      t.string :description
      t.string :application_status

      t.timestamps
    end
  end
end
