# frozen_string_literal: true
require 'codebreaker/game'

RSpec.describe 'SecretCode' do
  include Codebreaker
  let(:code) { Codebreaker::SecretCode.new }

  context '#initialize' do
    it 'initialize instant' do
      expect(code).to be_instance_of(Codebreaker::SecretCode)
    end
  end

  context '#generate' do
    it 'generate new code' do
      expect(code.generate).not_to eq('1111')
    end
  end
end
