# frozen_string_literal: true

require_relative 'lib/codebreaker/version'

Gem::Specification.new do |spec|
  spec.name = 'codebreaker'
  spec.version = Codebreaker::VERSION
  spec.authors = ['Vasyl']
  spec.email = ['vasyl.laba@rubygarage.org']

  spec.summary = 'Codebreaker game gem'
  spec.description = 'My game'
  # spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1.0'

  spec.metadata['allowed_push_host'] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = 'https://github.com/vasyllabaruby/codebreaker'
  spec.metadata['source_code_uri'] = 'https://github.com/vasyllabaruby/codebreaker'
  spec.metadata['changelog_uri'] = 'https://github.com/vasyllabaruby/codebreaker'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.3'
  spec.add_development_dependency 'fasterer'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.30'
  spec.add_development_dependency 'simplecov'
end
