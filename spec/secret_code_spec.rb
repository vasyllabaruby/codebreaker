# frozen_string_literal: true

require 'codebreaker/game'
require 'codebreaker/secret_code'

RSpec.describe 'SecretCode' do
  let(:code_size) { Codebreaker::SecretCodeGenerator.const_get(:CODE_SIZE) }
  context '#initialize' do
    it 'initialize instant' do
      expect(Codebreaker::SecretCodeGenerator.generate).to be_instance_of(String)
    end
  end

  context '#generate' do
    it 'Check code size' do
      expect(Codebreaker::SecretCodeGenerator.generate.length).to eq(code_size)
    end
    it 'Check code values' do
      expect(Codebreaker::SecretCodeGenerator.generate).to match(/^[1-6]{#{code_size}}$/)
    end
  end
end
