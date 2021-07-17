require 'rails_helper'

RSpec.describe AdoptApplication do
  describe 'relationships' do
    it { should have_many :application_pets }
  end
end
