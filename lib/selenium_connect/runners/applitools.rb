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

        eyes.open(app_name: selenium_connect_hash[:device], test_name: selenium_connect_hash[:job_name], driver: driver)
      end

    end # AppliTools
  end # Runner
end # SeleniumConnect
