# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_ups_worldship'
  s.version     = '0.1.2'
  s.summary     = 'Better integration with UPS WorldShip'
  s.description = 'Integrating with UPS sucks, this gem makes it less-sucky'
  s.required_ruby_version = '>= 1.8.7'

  s.author    = 'Pete Campbell'
  # s.email     = 'you@example.com'
  s.homepage  = 'http://www.github.com/campbell/spree_ups_worldship'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.3'

#  s.add_development_dependency 'capybara', '~> 2.0'
#  s.add_development_dependency 'coffee-rails'
#  s.add_development_dependency 'factory_girl', '~> 4.2'
#  s.add_development_dependency 'ffaker'
#  s.add_development_dependency 'rspec-rails',  '~> 2.13'
#  s.add_development_dependency 'sass-rails'
#  s.add_development_dependency 'sqlite3'
end
