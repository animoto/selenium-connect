# Encoding: utf-8

require 'spec_helper'
require 'selenium_connect'

describe SeleniumConnect, selenium: true do

  it 'should run a simple job by default' do
    config = SeleniumConnect::Configuration.new
    sc = SeleniumConnect.start config
    job = sc.create_job
    driver = job.start

    execute_simple_test driver

    driver.get 'http://www.google.com'
    driver.title.should include('Google')

    job.finish
    sc.finish
  end

  it 'should return log files to a location' do
    log_path = File.join('build', 'tmp')
    config = SeleniumConnect::Configuration.new log: log_path
    sc = SeleniumConnect.start config
    job = sc.create_job
    driver = job.start

    execute_simple_test driver

    job.finish
    sc.finish

    server_log = File.read(File.join(ENV['BUILD_PATH'], 'tmp', 'server.log'))
    server_log.empty?.should be false

    # TODO: firefox.log is not being written by geckodriver - This will probably be fixed at some
    # point, and we should pull that fix in, but I don't consider it important enough to
    # spend time on now.
    # browser_log = File.read(File.join(ENV['BUILD_PATH'], 'tmp', 'firefox.log'))
    # browser_log.empty?.should be false
  end
end
