require 'selenium-connect/configuration'
require 'selenium-connect/runners/phantomjs'

describe "phantomjs runner" do
  it "should match against phantomjs if configured as such" do
    config = SeleniumConnect::Configuration.new()
    config.browser = 'phantomjs';
    runner = SeleniumConnect::Runner::PhantomJS.new(config)
    runner.match?.should be_true
  end

  it "should not match if there is a different browser specified" do
    config = SeleniumConnect::Configuration.new()
    config.browser = 'chrome';
    runner = SeleniumConnect::Runner::PhantomJS.new(config)
    runner.match?.should be_false
  end

  it "should return a symbol for the browser on launch" do
    config = SeleniumConnect::Configuration.new()
    config.browser = 'phantomjs';
    runner = SeleniumConnect::Runner::PhantomJS.new(config)
    runner.launch.should be :phantomjs
  end
end