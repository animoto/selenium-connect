# Encoding: utf-8

class SeleniumConnect
  # Runner
  class Runner
    # Firefox browser runner
    class Firefox
      attr_reader :config

      def initialize(config)
        @config = config
      end

      def match?
        config.browser == 'firefox'
      end

      def launch
        init_browser
      end

      private

      def get_profile
        if config.profile_path
          Selenium::WebDriver::Firefox::Profile.new config.profile_path
        elsif config.profile_name
          Selenium::WebDriver::Firefox::Profile.from_name config.profile_name
        else
          Selenium::WebDriver::Firefox::Profile.new
        end
      end

      def config_browser
        profile = get_profile
        profile.assume_untrusted_certificate_issuer = false unless profile.nil?
        profile.log_file = File.join(Dir.getwd, config.log, 'firefox.log') if config.log
        profile['network.negotiate-auth.trusted-uris']  = '.animoto.com'
        profile['network.automatic-ntlm-auth.trusted-uris']  = '.animoto.com'
        browser = Selenium::WebDriver::Remote::Capabilities.firefox
        browser[:firefox_binary] = config.browser_path if config.browser_path
        browser[:firefox_profile] = profile
        browser[:marionette] = true
        browser
      end

      def init_browser
        config_browser
      end

    end # Firefox
  end # Runner
end # SeleniumConnect
