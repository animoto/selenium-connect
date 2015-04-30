Gem::Specification.new do |s|
  s.name          = 'selenium-connect'
  s.version       = '3.7.1'
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

  s.add_dependency 'selenium-webdriver', '~> 2.41'
  s.add_dependency 'rake'
  s.add_dependency 'sauce', '~> 3.5.3'
  s.add_dependency 'sauce-connect'
  s.add_dependency 'sauce_whisk', '~> 0.0.15'
  s.add_dependency 'appium_lib', '~> 6.0.0'
  s.add_dependency 'eyes_selenium'
end
