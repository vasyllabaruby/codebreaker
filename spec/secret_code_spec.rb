# frozen_string_literal: true

require 'codebreaker/game'

RSpec.describe 'SecretCode' do
  let(:code) { SecretCodeGenerator::SecretCode.new }

  context '#initialize' do
    it 'initialize instant' do
      expect(SecretCodeGenerator.generate).to be_instance_of(String)
    end
  end

  context '#generate' do
    it 'Check code size' do
      expect(SecretCodeGenerator.generate.length).to eq(::SecretCodeGenerator.const_get(:CODE_SIZE))
    end
    it 'Check code values' do
      expect(SecretCodeGenerator.generate).to match(/^[1-6]{#{::SecretCodeGenerator.const_get(:CODE_SIZE)}}$/)
    end
  end
end
