# Encoding: utf-8

require 'spec_helper'
require 'selenium_connect/job/ie_job'

describe SeleniumConnect::Job::IeJob do
  let(:job) do
    config = double 'SeleniumConnect::Config::Job'
    config.should_receive(:opts).and_return({})
    SeleniumConnect::Job::IeJob.new config
  end

  it 'can be run with sauce' do
    job.should respond_to :run_with_sauce_runner
  end
end