# Encoding: utf-8

require 'selenium_connect/runners/firefox'
require 'selenium_connect/runners/ie'
require 'selenium_connect/runners/chrome'
require 'selenium_connect/runners/phantomjs'
require 'selenium_connect/runners/no_browser'
require 'selenium_connect/runners/ios'
require 'selenium_connect/runners/saucelabs'
require 'selenium_connect/runners/android'

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
      "http://#{config.host}:#{config.port}/wd/hub"
    end

    def init_driver
      if config.host == 'saucelabs'
        Saucelabs.new(config).launch
      else
        Selenium::WebDriver.for(
          :remote,
          url: set_server_url,
          desired_capabilities: get_browser
        )
      end
    end

    def get_browser
      browser = browsers.find { |found_browser| found_browser.match? }
      browser.launch
    end

    def browsers
      firefox     = Firefox.new(config)
      ie          = InternetExplorer.new(config)
      chrome      = Chrome.new(config)
      phantomjs   = PhantomJS.new(config)
      no_browser  = NoBrowser.new(config)
      android     = Android.new(config)
      [firefox, ie, chrome, phantomjs, iOS, android, no_browser]
    end

  end # Runner
end # SeleniumConnect
