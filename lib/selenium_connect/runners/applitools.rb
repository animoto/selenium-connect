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

        eyes = Applitools::Eyes.new
        eyes.api_key = config.applitools_opts[:applitools_key]
        test_name = if selenium_connect_hash.include?(:device)
                     'mobile' + selenium_connect_hash[:device]
                   else
                     'web' + selenium_connect_hash[:browser] + selenium_connect_hash[:browser_version]
		   end

        if driver.is_a? Sauce::Selenium2
          @driver = driver.driver #yo dawg. I heard you like drivers.
        end

        eyes.open(app_name: selenium_connect_hash[:job_name], test_name: test_name, driver: driver)
      end

    end # AppliTools
  end # Runner
end # SeleniumConnect
