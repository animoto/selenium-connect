# Encoding: utf-8

class SeleniumConnect
  # Runner
  class Runner
    # Safari Browser Runner
    class Safari
      attr_reader :config

      def initialize(config)
        @config = config
      end

      def match?
        config.browser == 'safari'
      end

      def launch
        init_browser
      end

      private

      def init_browser
        config.browser.to_sym
      end

    end # Safari
  end # Runner
end # SeleniumConnect
