# Encoding: utf-8

require 'spec_helper'
require 'selenium_connect'

describe 'Firefox', selenium: true do

  it 'blank config' do
    @config = SeleniumConnect::Configuration.new
    sc = SeleniumConnect.start @config
    job = sc.create_job
    driver = job.start
    execute_simple_test driver
    job.finish
    sc.finish
  end

  it 'localhost' do
    @config = SeleniumConnect::Configuration.new host: 'localhost', log: '/build/tmp'
    sc = SeleniumConnect.start @config
    job = sc.create_job
    driver = job.start
    execute_simple_test driver
    job.finish failshot: true
    sc.finish

    File.exist?(File.join(ENV['BUILD_PATH'], 'tmp', 'firefox.log')).should be_true
    File.exist?(File.join(ENV['BUILD_PATH'], 'tmp', 'dom_0.html')).should be_true
    File.exist?(File.join(ENV['BUILD_PATH'], 'tmp', 'failshot.png')).should be_true
    File.exist?(File.join(ENV['BUILD_PATH'], 'tmp', 'server.log')).should be_true
  end

  it 'local jar file specified' do
    opts = {
      host: 'localhost',
      jar: "#{Dir.pwd}/bin/selenium-server-standalone-2.41.0.jar"
    }
    @config = SeleniumConnect::Configuration.new opts
    sc = SeleniumConnect.start @config
    job = sc.create_job
    driver = job.start
    execute_simple_test driver
    job.finish
    sc.finish
  end

  it 'profile name' do
    pending 'requires machine setup to run, and need a public example'
    @config = SeleniumConnect::Configuration.new profile_name: 'YourProfileNameGoesHere'
  end

  it 'profile path' do
    pending 'need to add a profile to the repo'
    @config = SeleniumConnect::Configuration.new profile_path: "#{Dir.pwd}/path/to/profile"
  end

  it 'browser path' do
    # example only works on Mac
    opts = {
      browser: 'firefox',
      browser_path: '/Applications/Firefox.app/Contents/MacOS/firefox'
    }
    @config = SeleniumConnect::Configuration.new opts
    sc = SeleniumConnect.start @config
    job = sc.create_job
    driver = job.start
    execute_simple_test driver
    job.finish
    sc.finish
  end

  it 'should download all the dom dumps if there are multiple windows open' do
    config = SeleniumConnect::Configuration.new browser: 'firefox', log: '/build/tmp'
    sc = SeleniumConnect.start config
    job = sc.create_job
    driver = job.start

    driver.get 'http://the-internet.herokuapp.com/windows'
    driver.find_element(css: '.example a').click
    unless driver.title =~ /Poogle/
      # simulate a failure situation
      job.finish failed: true, failshot: true
    end
    File.exist?(File.join(ENV['BUILD_PATH'], 'tmp', 'dom_0.html')).should be_true
    File.exist?(File.join(ENV['BUILD_PATH'], 'tmp', 'dom_1.html')).should be_true
    sc.finish
  end
end
