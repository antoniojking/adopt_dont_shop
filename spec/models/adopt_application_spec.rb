require 'rails_helper'

RSpec.describe AdoptApplication do
  describe 'relationships' do
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end
end
