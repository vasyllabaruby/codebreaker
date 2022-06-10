# frozen_string_literal: true

require 'codebreaker/game'

RSpec.describe 'ValidateService' do
  context '.valid?' do
    it 'Validate service test valid? false' do
      expect(Codebreaker::ValidateService.code_valid?('1237')).to eq(false)
    end
    it 'Validate service test valid? true' do
      expect(Codebreaker::ValidateService.code_valid?('1336')).to eq(true)
    end
  end
  context '.name_valid?' do
    it 'Validate service test name_valid? true' do
      expect(Codebreaker::ValidateService.name_valid?('Vasyl')).to eq(true)
    end
    it 'Validate service test name_valid? false' do
      expect(Codebreaker::ValidateService.name_valid?('V')).to eq(false)
    end
  end
end
