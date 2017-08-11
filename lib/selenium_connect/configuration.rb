# Encoding: utf-8

require 'yaml'
require 'ostruct'

# selenium connect
class SeleniumConnect
  # Encapsulates the configuration
  class Configuration

    # Selenium Server
    attr_accessor :host, :port, :version,
                  :background, :log, :jar

    # Browsers
    attr_accessor :browser_path, :profile_path, :profile_name

    # SauceLabs
    attr_accessor :sauce_username, :sauce_api_key, :api_timeout, :chromeOptions, :screen_resolution, :prerun

    attr_reader :sauce_opts, :browser, :description, :os, :browser_version

    # BrowserStack
    attr_accessor :browserstack_username, :browserstack_api_key, :browserstack_opts

    attr_accessor :os_version, :resolution

    # Appium
    attr_accessor :app, :device, :newCommandTimeout, :autoAcceptAlerts, :keepKeyChains, :appium_version, :platformName, :platformVersion, :deviceName, :caps

    # TestDroid
    attr_accessor :testdroid_username, :testdroid_password, :testdroid_project, :testdroid_description, :testdroid_testrun, :testdroid_app, :testdroid_device

    def initialize(opts = {})
      @host     = 'localhost'
      @port     = 4444
      @browser  = 'firefox'
      @sauce_opts = OpenStruct.new
      populate_with_hash opts unless opts.empty?
    end

    # TODO: eventually roll all sauce options under this node
    # and deprecate setting them at the top level
    def sauce_opts=(opts = {})
      opts.each do |key, value|
        @sauce_opts.send("#{key}=", value) unless value.nil?
      end
    end

    def populate_with_hash(hash)
      hash.each do |key, value|
        begin
          send "#{key}=", value unless value.nil?
        rescue NoMethodError
          raise ArgumentError.new "The config key: \"#{key}\" is unknown!"
        end
      end
    end

    def populate_with_yaml(file)
      populate_with_hash YAML.load_file file
    end

    # The below methods are setters for the explicitly defined sauce and browser
    # options, the is support future refactoring to a strutted config
    # but maintains compatability for now.
    def os=(os)
      @os = os
      @sauce_opts.os = os
    end

    def browser_version=(browser_version)
      @browser_version = browser_version
      @sauce_opts.browser_version = browser_version if @sauce_opts.browser_version.nil?
    end

    def description=(description)
      @description = description
      @sauce_opts.job_name = description if @sauce_opts.job_name.nil?
    end

    def browser=(browser)
      @browser = browser
      @sauce_opts.browser = browser if @sauce_opts.browser.nil?
    end

    alias_method :config_file=, :populate_with_yaml

  end # Configuration
end # SeleniumConnect
