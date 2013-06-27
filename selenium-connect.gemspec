Gem::Specification.new do |s|
  s.name          = 'selenium-connect'
  s.version       = '1.9.3'
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Dave Haeffner', 'Jason Fox']
  s.email         = ['dave@arrgyle.com', 'jason@arrgyle.com']
  s.homepage      = 'https://github.com/arrgyle/selenium-connect'
  s.summary       = 'A stupid simple way to run your Selenium tests on localhost, against a Selenium Grid, or in the cloud (e.g. SauceLabs).'
  s.description   = 'Fixed logging bug.'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.files.reject! { |file| file.include? '.jar' }
  s.require_paths = ['lib']

  s.required_ruby_version = '>=1.9'

  s.add_dependency 'selenium-webdriver'
  s.add_dependency 'rake'
  s.add_dependency 'sauce', '~> 2.4.4'

  s.add_development_dependency 'rspec'

end
