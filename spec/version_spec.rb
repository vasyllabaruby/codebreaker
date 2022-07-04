# frozen_string_literal: true

require 'codebreaker/game'

RSpec.describe 'Version' do
  include Codebreaker
  it 'has a version number' do
    expect(Codebreaker::VERSION).not_to be nil
  end
end
