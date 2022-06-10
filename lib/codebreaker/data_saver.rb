# frozen_string_literal: true

require 'rdoc'
require 'yaml'

module Codebreaker
  # Module for saving data in file
  module DataSaver
    DEFAULT_FILENAME = 'Statistics.data'

    def save(data, filename = DEFAULT_FILENAME)
      File.open(filename, 'w') { |f| f.write(YAML.dump(data)) }
    end

    def load(filename = DEFAULT_FILENAME)
      Psych.unsafe_load(File.read(filename)) if File.exist? filename
    end
  end
end
