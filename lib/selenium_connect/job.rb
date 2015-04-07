# Encoding: utf-8

require 'selenium_connect/runner'
require 'sauce/client'
require 'rest_client'
require 'selenium-webdriver'
require 'json'
require 'sauce_whisk'

require 'eyes_selenium'

# selenium connect
class SeleniumConnect
  # encapsulates the creation of a driver and a run
  class Job

    def initialize(config, report_factory, sauce_facade)
      @config = config
      @report_factory = report_factory
      @sauce_facade = sauce_facade
    end

    # Creates and returns the driver, using options passed in
    def start(opts = {})
      # TODO: this could be refactored out into an options parser of sorts
      @job_name = opts.key?(:name) ? slugify_name(opts[:name]) : 'unnamed_job'
      sauce_config = {}
      sauce_config.merge!(opts[:sauce_opts]) if opts.key? :sauce_opts
      sauce_config.merge!(job_name: @job_name)
      @config.sauce_opts = sauce_config
      @driver = Runner.new(@config).driver
    end

    # Finishes the driver run, taking any data to help, returning report
    def finish(opts = {})

      # extracted from the earlier main finish
      begin
        if opts.key?(:failshot) && opts[:failshot] && @config.host != 'saucelabs' || @config.host == 'appium'
          save_screenshot
        end
        @driver.quit
        @driver.eyes.abort_if_not_closed if @driver.is_a? Applitools::Driver
        @data = { assets: {} }
        process_sauce_logs(opts) if @config.host == 'saucelabs' || @config.host == 'appium'
      # rubocop:disable HandleExceptions
      rescue Selenium::WebDriver::Error::WebDriverError
      # rubocop:enable HandleExceptions
      end
      @report_factory.build :job, @data
    end

    private

      def save_screenshot
        path = File.join(Dir.getwd, @config.log, 'failshot.png')
        @driver.save_screenshot path unless @driver.is_a? Applitools::Driver
      end

      def save_html
        dom_number = 0
        @driver.window_handles.each do |handle|
          @driver.switch_to.window(handle)
          save_asset("dom_#{dom_number}.html", @driver.page_source)
          dom_number += 1
        end
      end

      def process_sauce_logs(opts = {})
        return if @driver.is_a? Applitools::Driver
        job_id = @driver.session_id
        @sauce_facade.job_id = job_id
        if opts.key?(:failed) && opts[:failed]
          status = 'failed'
          @sauce_facade.fail_job
          if opts.key?(:failshot) && opts[:failshot]
            screenshot = @sauce_facade.fetch_last_screenshot
            @data[:assets][:failshot] = save_asset('failshot.png', screenshot) if screenshot
          end
          if (@config.sauce_opts.download_videos)
            video_file = @sauce_facade.fetch_video
            @data[:assets][:video] = save_asset('video.flv', video_file) if video_file
          end
        end
        if opts.key?(:passed) && opts[:passed]
          status = 'passed'
          @sauce_facade.pass_job
        end
        server_log = @sauce_facade.fetch_server_log
        @data[:assets][:server_log] = save_asset('server.log', server_log) if server_log

        job_data = @sauce_facade.fetch_job_data
        @data[:sauce_data] = job_data if job_data

        job_data_log_file = 'sauce_job.log'
        @data[:assets][:job_data_log] = job_data_log_file
        @data = symbolize_keys @data
        save_asset(job_data_log_file, @data)
      end

      def save_asset(filename, asset)
        if @config.log
          asset_file = File.join(Dir.getwd, @config.log, filename)
          File.open(asset_file, 'wb') { |f| f.write asset }
          filename
        end
      end

      def slugify_name(name)
        name.downcase.strip.gsub(' ', '_').gsub(/[^\w-]/, '')
      end

      # TODO: this should be pulled out into a generic report... or something
      def symbolize_keys(hash)
        hash.reduce({}) do |result, (key, value)|
          new_key = key.class == String ? key.to_sym : key
          new_value = value.class == Hash ? symbolize_keys(value) : value
          result[new_key] = new_value
          result
        end
      end
  end
end

