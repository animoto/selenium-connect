# Encoding: utf-8

require 'spec_helper'
require 'selenium_connect'

describe 'Sauce Labs', selenium: true do

  before(:each) do
    opts = {
      log: File.join('build', 'tmp'),
      host: 'saucelabs',
      sauce_username: 'animototestteam',
      sauce_api_key: 'b211071e-8473-4e24-90de-8785cc03f297',
      os: 'windows 10',
      browser: 'chrome',
      browser_version: '55',
      sauce_opts: { selenium_version: '3.0.1' },
      description: 'test description'
    }
    config = SeleniumConnect::Configuration.new opts
    @sc = SeleniumConnect.start config
  end

  it 'just execute a sauce job successfully' do
    job = @sc.create_job
    name = 'successful sauce job'
    driver = job.start name: name, sauce_opts: { public: 'share' }
    execute_simple_test driver
    report = job.finish passed: true
    report.data[:sauce_data][:name].should be == 'successful_sauce_job'
    report.data[:sauce_data][:passed].should be_true
    report.data[:sauce_data][:public].should eq 'share'
    report.data[:assets][:server_log].should eq 'server.log'
    File.exist?(File.join(Dir.pwd, 'build', 'tmp', 'server.log')).should be_true
  end

  it 'should mark a sauce job as failed' do
    job = @sc.create_job
    name = 'failing sauce job'
    job.start name: name
    # we don't even need to run anything
    report = job.finish failed: true
    report.data[:sauce_data][:passed].should be false
  end

  it 'should download a screenshot on failure' do
    # pending 'need to resolve the api issues first'
    job = @sc.create_job
    name = 'failshot'
    driver = job.start name: name

    driver.get 'http://www.yahoo.com'
    driver.get 'http://www.google.com'

    unless driver.title =~ /Poogle/
      # simulate a failure situation
      report = job.finish failed: true, failshot: true
    end
    report.data[:sauce_data][:passed].should be false
    report.data[:assets][:failshot].should be == 'failshot.png'
    File.exist?(File.join(Dir.pwd, 'build', 'tmp', 'failshot.png')).should be_true
  end

  after(:each) do
    @sc.finish
  end
end
