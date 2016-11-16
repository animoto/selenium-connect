Gem::Specification.new do |s|
  s.name          = 'selenium-connect'
  s.version       = '4.0.0'
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Dave Haeffner', 'Jason Fox']
  s.email         = ['dave@arrgyle.com', 'jason@arrgyle.com']
  s.homepage      = 'https://github.com/arrgyle/selenium-connect'
  s.summary       = 'A stupid simple way to run your Selenium tests on localhost, against a Selenium Grid, or in the cloud (e.g. SauceLabs).'
  s.description   = 'Updated Selenium gems and binaries so they are current'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.require_paths = ['lib']

  s.required_ruby_version = '>=1.9'

  s.add_dependency 'selenium-webdriver'
  s.add_dependency 'rake'
  s.add_dependency 'sauce', '3.7.2'
  s.add_dependency 'sauce-connect'
  s.add_dependency 'sauce_whisk'
  s.add_dependency 'appium_lib', '~> 8.0.0'
end
