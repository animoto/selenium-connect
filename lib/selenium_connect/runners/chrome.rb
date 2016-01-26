# Encoding: utf-8

class SeleniumConnect
  # Runner
  class Runner
    # Chrome browser runner
    class Chrome
      attr_reader :config

      def initialize(config)
        @config = config
      end

      def match?
        config.browser == 'chrome'
      end

      def launch
        init_browser
      end

      private

      def init_browser
        caps = Selenium::WebDriver::Remote::Capabilities.chrome

        if config.log
          log_path = File.join(Dir.getwd, config.log, 'chrome')
          caps['chrome.switches'] = ["--user-data-dir=#{log_path}", '--enable-logging', '--v=1', "--log-net-log=#{log_path}/net_log.log", '--net-log-level=0']
        end

        # Add the flag to bypass the media stream infobar by selecting the default device for media streams 
        caps['chromeOptions'] = {"args" => [ "--use-fake-ui-for-media-stream", "--disable-extensions", "--disable-notifications" ]}

        caps
      end

    end # Chrome
  end # Runner
end # SeleniumConnect
