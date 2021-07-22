class ApplicationPet < ApplicationRecord
  belongs_to :adopt_application
  belongs_to :pet
end
