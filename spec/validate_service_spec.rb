# frozen_string_literal: true

require 'codebreaker/game'

RSpec.describe 'ValidateService' do
  context '.valid?' do
    it 'Validate service test valid?' do
      expect(ValidateService.valid?(1237)).to eq(false)
    end
  end
  context '.name_valid?' do
    it 'Validate service test name_valid? true' do
      expect(ValidateService.name_valid?('Vasyl')).to eq(true)
    end
    it 'Validate service test name_valid? false' do
      expect(ValidateService.name_valid?('V')).to eq(false)
    end
  end
end
