# Encoding: utf-8

require 'eyes_selenium'

# selenium connect
class SeleniumConnect
  # Runner
  class Runner
    # Appium runner
    class AppliTools
      attr_reader :config, :driver

      def initialize(config, driver)
        @config = config
        @driver = driver
      end

      def launch
        selenium_connect_hash = config.sauce_opts.marshal_dump
        eyes                  = Applitools::Eyes.new

        if selenium_connect_hash.include?(:device)
          test_name = 'mobile' + selenium_connect_hash[:device]
        else
          test_name        = 'web' # + selenium_connect_hash[:browser] + selenium_connect_hash[:browser_version]
          eyes.match_level = Applitools::MatchLevel::LAYOUT
          viewport_size    = Struct.new(:width, :height).new(1024, 724)
          eyes.host_app    = nil
          eyes.host_os     = nil
        end

        eyes.api_key = config.applitools_opts[:applitools_key]


        if driver.is_a? Sauce::Selenium2
          @driver = driver.driver #yo dawg. I heard you like drivers.
        end

        eyes.open(app_name: selenium_connect_hash[:job_name], test_name: test_name, driver: driver, viewport_size: viewport_size)
      end

    end # AppliTools
  end # Runner
end # SeleniumConnect
