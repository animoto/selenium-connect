# Encoding: utf-8

class SeleniumConnect
  # Runner
  class Runner
    # Android Runner
    class Android
      attr_reader :config

      def initialize(config)
        @config = config
      end

      def match?
        config.browser == 'Android'
      end

      def launch
        init_browser
      end

      private

      def init_browser
        capabilities = {
            'browserName' => config.browser,
            'app' => config.app,
            'device' => config.device
        }
        capabilities
      end

    end # Android
  end # Runner
end # SeleniumConnect