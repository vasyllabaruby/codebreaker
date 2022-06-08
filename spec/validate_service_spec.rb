# frozen_string_literal: true

require 'codebreaker/game'

RSpec.describe 'ValidateService' do
  include Codebreaker
  context '.valid?' do
    it 'Validate service test valid?' do
      expect(Codebreaker.valid?(1237)).to eq(false)
    end
  end
  context '.name_valid?' do
    it 'Validate service test name_valid? true' do
      expect(Codebreaker.name_valid?('Vasyl')).to eq(true)
    end
    it 'Validate service test name_valid? false' do
      expect(Codebreaker.name_valid?('V')).to eq(false)
    end
  end
end