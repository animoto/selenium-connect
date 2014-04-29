# Encoding: utf-8

class SeleniumConnect
  # Runner
  class Runner
    # iOS Runner
    class TestDroid
      attr_reader :config

      def initialize(config)
        @config = config
      end

      def match?
        config.browser == 'testdroid'
      end

      def launch
        init_browser
      end

      private

      def init_browser
        capabilities = {
          'app' => config.app,
          'device' => config.device,
          'testdroid_username' => config.testdroid_username,
          'testdroid_password' => config.testdroid_password,
          'testdroid_project' => config.testdroid_project,
          'testdroid_description' => config.testdroid_description,
          'testdroid_testrun' => config.testdroid_testrun,
          'testdroid_app' => config.testdroid_app,
          'testdroid_device' => config.testdroid_device
        }
        capabilities
      end

    end # iOS
  end # Runner
end # SeleniumConnect
