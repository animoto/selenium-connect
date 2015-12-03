# Encoding: utf-8

require 'sauce'

# selenium connect
class SeleniumConnect
  # Runner
  class Runner
    # Sauce runner
    class BrowserStack
      attr_reader :config

      def initialize(config)
        @config = config
      end

      def launch
        init_browser
      end

      private

      def init_browser
        config.browserstack_opts[:'browserstack.debug'] = 'true'
        config.browserstack_opts[:'browserstack.video'] = 'true'
        config.browserstack_opts[:resolution] = '1920x1080'
        driver = Selenium::WebDriver.for(
          :remote,
          url: "http://#{config.browserstack_username}:#{config.browserstack_api_key}@hub.browserstack.com/wd/hub",
          desired_capabilities: config.browserstack_opts
        )
      end

    end # BrowserStack
  end # Runner
end # SeleniumConnect
