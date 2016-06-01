# Encoding: utf-8

require 'selenium_connect/job'
require 'selenium_connect/server'
require 'selenium_connect/configuration'
require 'sauce_labs/sauce_facade'
require 'selenium_connect/report/report_factory'

# Selenium Connect main module
class SeleniumConnect

  attr_reader :config

  # initializes and returns a new SeleniumConnect object
  def self.start(config)
    report_factory = SeleniumConnect::Report::ReportFactory.new
    new config, report_factory
  end

  def initialize(config, report_factory)
    raise ArgumentError, 'Instance of SeleniumConnect::Configuration expected.' unless config.is_a? SeleniumConnect::Configuration
    @config = config
    @report_factory = report_factory
    server_start
  end

  def create_job(opts = {})
    sauce_facade = SauceLabs::SauceFacade.new @config.api_timeout
    SeleniumConnect::Job.new @config, @report_factory, sauce_facade
  end

  def finish
    @server.stop unless @server.nil?
    # returning empty report for now
    @report_factory.build :main, {}
  end

  private

    def server_start
      if @config.host == 'localhost'
        # TODO: this is just temp,
        # in the next iteration we will inject this in by default in start
        # to a required argument in initialize
        @server = Server.new(config)
        @server.start
      else
        @server = nil
      end
    end
end
