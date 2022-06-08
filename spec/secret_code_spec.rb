# frozen_string_literal: true

require 'codebreaker/game'

RSpec.describe 'SecretCode' do
  let(:code) { SecretCodeGenerator::SecretCode.new }

  context '#initialize' do
    it 'initialize instant' do
      expect(code).to be_instance_of(SecretCodeGenerator::SecretCode)
    end
  end

  context '#generate' do
    it 'generate new code' do
      expect(code.generate).not_to eq('1111')
    end
  end
end
