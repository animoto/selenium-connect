# Encoding: utf-8

require 'appium_lib'

# selenium connect
class SeleniumConnect
  # Runner
  class Runner
    # Appium runner
    class AppiumLib
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

        capabilities = { caps: {
          'app' => config_hash[:app],
          'deviceName' => config_hash[:device],
          'platformName' => config_hash[:platformName],
          'platformVersion' => config_hash[:platformVersion],
          'name' => config_hash[:job_name],
          'appiumVersion' => config_hash[:appiumVersion],
          'autoAcceptAlerts' => config_hash[:autoAcceptAlerts],
          'newCommandTimeout' => config_hash[:newCommandTimeout],
          'idleTimeout' => config_hash[:idleTimeout],
          'maxDuration' => config_hash[:maxDuration],
          'waitForAppScript' => config_hash[:waitForAppScript],
          'showIOSLog' => config_hash[:showIOSLog],
          'nativeInstrumentsLib' => config_hash[:nativeInstrumentsLib],
          'safariIgnoreFraudWarning' => config_hash[:safariIgnoreFraudWarning],
          'androidPackage' => config_hash[:androidPackage]
          }
        }
        # hooks for diagnosing flakiness
        puts config_hash[:job_name]
        puts capabilities
        driver = Appium::Driver.new(capabilities)
        x = driver.start_driver
        puts driver.server_url
        puts driver.appium_server_version
        x
      end

    end # Saucelabs
  end # Runner
end # SeleniumConnect
