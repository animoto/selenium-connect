# Encoding: utf-8

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
        # TODO: clean this up and pull it to the config... and clean up that config
        get_credentials
        config_hash = config.sauce_opts.marshal_dump
        config_hash['browserName'] = config_hash[:browser]
        config_hash['platform'] = config_hash[:os]
        config_hash['version'] = config_hash[:browser_version]
        config_hash['selenium-version'] = config_hash[:selenium_version] if config_hash[:selenium_version].nil? == false
        config_hash['screen-resolution'] = config_hash[:screen_resolution] if config_hash[:screen_resolution].nil? == false
        config_hash.delete :selenium_version
        config_hash.delete :browser        
        config_hash.delete :screen_resolution
        config_hash.delete :os
        config_hash.delete :browser_version
        Selenium::WebDriver.for(:remote,
          :url => "http://#{config.sauce_username}:#{config.sauce_api_key}@ondemand.saucelabs.com:80/wd/hub",
          :desired_capabilities => config_hash)
      end

    end # Saucelabs
  end # Runner
end # SeleniumConnect
