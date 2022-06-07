require 'codebreaker'

RSpec.describe 'SecretCode' do
  let(:code) { Codebreaker::SecretCode.new('1111') }

  context '#initialize' do
    it 'initialize instant' do
      expect(code).to be_instance_of(Codebreaker::SecretCode)
    end
  end

  context '#get' do
    it 'get code' do
      expect(code.get).to eq('1111')
    end
  end

  context '#generate' do
    it 'generate new code' do
      code.generate
      expect(code.get).not_to eq('1111')
    end
  end
end
