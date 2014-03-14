# Encoding: utf-8

require 'sauce'

# selenium connect
class SeleniumConnect
  # Runner
  class Runner
    # Sauce runner
    class Saucelabs
      attr_reader :config

      def initialize(config)
        @config = config
      end

      def launch
        init_browser
      end

      private

      def get_credentials
        ENV['SAUCE_USERNAME'] = config.sauce_username
        ENV['SAUCE_ACCESS_KEY'] = config.sauce_api_key
      end

      def init_browser
        get_credentials
        # TODO: clean this up and pull it to the config... and clean up that config
        config_hash = config.sauce_opts.marshal_dump
        config_hash['selenium-version'] = config_hash[:selenium_version] if config_hash[:selenium_version].nil? == false
        config_hash.delete :selenium_version
        Sauce::Selenium2.new(config_hash)
      end

    end # Saucelabs
  end # Runner
end # SeleniumConnect
