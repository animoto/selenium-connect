# Encoding: utf-8

require 'selenium_connect/runners/firefox'
require 'selenium_connect/runners/ie'
require 'selenium_connect/runners/chrome'
require 'selenium_connect/runners/safari'
require 'selenium_connect/runners/phantomjs'
require 'selenium_connect/runners/no_browser'
require 'selenium_connect/runners/ios'
require 'selenium_connect/runners/saucelabs'
require 'selenium_connect/runners/android'
require 'selenium_connect/runners/testdroid'
require 'selenium_connect/runners/appium_lib'
require 'selenium_connect/runners/browserstack'

# selenium connect
class SeleniumConnect
  # Initializes the driver
  class Runner
    attr_reader :driver, :config

    def initialize(config)
      @config = config
      @driver = init_driver
    end

    private

    def set_server_url
      if config.port.nil?
        "http://#{config.host}/wd/hub"
      else
        "http://#{config.host}:#{config.port}/wd/hub"
      end
    end
    driver = nil

    def init_driver
      if config.host == 'saucelabs'
        driver = Saucelabs.new(config).launch
      elsif config.host == 'appium'
        driver = AppiumLib.new(config).launch
      elsif config.host == 'browserstack'
        driver = BrowserStack.new(config).launch
      else
        config.port = nil if config.browser == 'testdroid'
        driver = Selenium::WebDriver.for(
          :remote,
          url: set_server_url,
          desired_capabilities: get_browser
        )
      end
      driver
    end

    def get_browser
      browser = browsers.find { |found_browser| found_browser.match? }
      browser.launch
    end

    def browsers
      firefox     = Firefox.new(config)
      ie          = InternetExplorer.new(config)
      chrome      = Chrome.new(config)
      safari      = Safari.new(config)
      phantomjs   = PhantomJS.new(config)
      no_browser  = NoBrowser.new(config)
      iOS         = IOS.new(config)
      android     = Android.new(config)
      testdroid   = TestDroid.new(config)
      [firefox, ie, chrome, safari, phantomjs, iOS, android, testdroid, no_browser]
    end

  end # Runner
end # SeleniumConnect
