# Encoding: utf-8

require 'spec_helper'
require 'selenium_connect/configuration'

describe SeleniumConnect::Configuration do

  VALID_JAR = 'test.jar'
  VALID_HOST = '111.000.111.000'
  VALID_SAUCE_USERNAME = 'test_user_name'

  before :each do
    @configuration = SeleniumConnect::Configuration.new
  end

  it 'can recieve a simple hash of options on initialization' do
    config = SeleniumConnect::Configuration.new host: 'newhost'
    config.host.should == 'newhost'
  end

  it 'can be populated by a hash' do
    @configuration.populate_with_hash jar: VALID_JAR, host: VALID_HOST
    @configuration.jar.should eq VALID_JAR
    @configuration.host.should eq VALID_HOST
  end

  it 'can be populated with a yaml file' do
    @configuration.populate_with_yaml "#{ENV['SUPPORT_PATH']}/example.yaml"
    @configuration.sauce_username.should eq VALID_SAUCE_USERNAME
  end

  it 'supports the config_file= method' do
    @configuration.config_file = "#{ENV['SUPPORT_PATH']}/example.yaml"
    @configuration.sauce_username.should eq VALID_SAUCE_USERNAME
  end

  it 'should throw an exception for unsupported config variable' do
    expect do
      @configuration.populate_with_hash  bad: 'config-value'
    end.to raise_error ArgumentError, 'The config key: "bad" is unknown!'
  end

  it 'sensible defaults persist when nothing is set' do
    @configuration.host.should eq     'localhost'
    @configuration.port.should eq     4444
    @configuration.browser.should eq  'firefox'
  end

  it 'should allow for an arbitrary hash of sauce configuration' do
    @configuration.populate_with_hash sauce_opts: { record_video: true, capture_html: true }
    @configuration.sauce_opts.record_video.should be_true
    @configuration.sauce_opts.capture_html.should be_true
  end

  # the goal here is to allow internal refactoring to use the new configuration pattern
  # to support deprecating the top level configs later
  it 'should merge the explicitly configured sauce options into the strut' do
    os = 'Linux'
    browser_version = '10'
    browser = 'chrome'
    description = 'test'
    @configuration.populate_with_hash os: os, browser_version: browser_version, browser: browser, description: description
    @configuration.sauce_opts.os.should eq os
    @configuration.sauce_opts.browser.should eq browser
    @configuration.sauce_opts.browser_version.should eq browser_version
    @configuration.sauce_opts.job_name.should eq description
  end

  it 'should take the sauce_opts as priority' do
    @configuration.populate_with_hash sauce_opts: { browser: 'ie', job_name: 'cool' }, browser: 'chrome', description: 'other'
    @configuration.sauce_opts.browser.should eq 'ie'
    @configuration.description.should eq 'other'
    @configuration.sauce_opts.job_name.should eq 'cool'
  end

  it 'should use the description as the job name if no job name is specified' do
    @configuration.populate_with_hash description: 'other'
    @configuration.description.should eq 'other'
    @configuration.sauce_opts.job_name.should eq 'other'
  end
end
