# Encoding: utf-8

require 'spec_helper'
require 'sauce_labs/sauce_facade'

describe Sauce::SauceFacade do

  before(:each) do
    @facade = Sauce::SauceFacade.new
  end

  it 'should be initialized' do
    @facade.should be_an_instance_of Sauce::SauceFacade
    @facade.timeout.should be == 10
  end

  it 'can be initialized with an optional time out value' do
    facade = Sauce::SauceFacade.new 30
    facade.timeout.should be == 30
  end

  it 'should respond to fail_job' do
    @facade.should respond_to :fail_job
  end

  it 'should respond to pass_job' do
    @facade.should respond_to :pass_job
  end

  it 'should respond to fetch_last_screenshot' do
    @facade.should respond_to :fetch_last_screenshot
  end

  it 'should respond to fetch_server_log' do
    @facade.should respond_to :fetch_server_log
  end

  it 'should respoind to fetch_job_data' do
    @facade.should respond_to :fetch_job_data
  end

  it 'should respond to job_id' do
    @facade.should respond_to :job_id
    @facade.should respond_to :job_id=
  end

  it 'should raise and exception if a function is called that requires an id but it is not set' do
    [:fail_job, :pass_job, :fetch_last_screenshot, :fetch_server_log, :fetch_job_data].each do |method|
      expect do
        @facade.send method
      end.to raise_error ArgumentError, "#{method.to_s} requires that the job_id be set in this object."
    end
  end
end

