#selenium-connect 3.7.1 (2014-04-13)

[![Gem Version](https://badge.fury.io/rb/selenium-connect.png)](http://badge.fury.io/rb/selenium-connect) [![Build Status](https://travis-ci.org/arrgyle/selenium-connect.png?branch=develop)](https://travis-ci.org/arrgyle/selenium-connect) [![Code Climate](https://codeclimate.com/github/arrgyle/selenium-connect.png)](https://codeclimate.com/github/arrgyle/selenium-connect) [![Coverage Status](https://coveralls.io/repos/arrgyle/selenium-connect/badge.png?branch=develop)](https://coveralls.io/r/arrgyle/selenium-connect?branch=develop)

A stupid simple way to run your Selenium tests on your computer, against a Selenium Grid, or in the cloud (e.g. SauceLabs). For a rocking implementation of this library, checkout [ChemistryKit](https://github.com/arrgyle/chemistrykit)! For more usage examples check out our [Friends](#friends) section!

All the documentation for Selenium Connect can be found in this README, organized as follows:

- [Getting Started](#getting-started)
- [Helpful Bits](#helpful-bits)
- [Configuration](#configuration)
- [Contribution Guidelines](#contribution-guidelines)
- [Deployment](#deployment)
- [Friends](#friends)

## Getting Started
```ruby
require 'selenium-connect'

# generate a config object
config = SeleniumConnect::Configuration.new browser: 'firefox'

# get connected
sc = SeleniumConnect.start config

# create a job
job = sc.create_job

# start the job to get a driver
@driver = job.start

# get on the road!
@driver = SeleniumConnect.start
@driver.get "http://www.google.com"

# finish your job
job.finish

# go have some fun!
sc.finish
```

## Helpful Bits

### Start
If host is set to "localhost" and no jar file is specified, it will run the version of [selenium-standalone-server.jar](https://code.google.com/p/selenium/downloads/list) that is bundled with the library (currently 2.33.0). Or, you can specify your own jar if you have one you prefer to use. This is done with c.jar = 'path-to-jar-file'.

If no additional parameters are set, the Selenium Server will be run in the background with logging disabled. If a logging directory is provided (with c.log = 'path-to-log-dir') then the following output files will be generated:

- Selenium Server JSON Wire Protocol output (server.log)
- firefox.log (If using Firefox as the browser)
- chrome.log (If using Chrome as the browser)
- dom_0.html (Or dom_1.html etc for each open window at the time the job is finished, a dump of the html)
- failshot.png (If failshot is marked as true, a screenshot of the end state)

This localhost functionality is driven using the [Selenium Rake Server Task](http://selenium.googlecode.com/svn/trunk/docs/api/rb/Selenium/Rake/ServerTask.html).

### Finish
The finish command issues a quit command to the driver and stops the local server if your host is set to "localhost".

### Support
- [Firefox](https://github.com/arrgyle/selenium-connect/blob/develop/spec/acceptance/firefox_spec.rb)
- [Chrome](https://github.com/arrgyle/selenium-connect/blob/develop/spec/acceptance/chrome_spec.rb)
- [Internet Explorer](https://github.com/arrgyle/selenium-connect/blob/develop/spec/acceptance/ie_spec.rb)
- [PhantomJS](https://github.com/arrgyle/selenium-connect/blob/develop/spec/acceptance/headless_spec.rb)
- [SauceLabs](https://github.com/arrgyle/selenium-connect/blob/develop/spec/acceptance/sauce_spec.rb)

## Configuration
Configuration of Selenium Connect is SUPER SIMPLE if you want it to be:

    config = SeleniumConnect::Configuration.new

By default it will run a local instance of selenium server on port 4444 and launch firefox. Get going without a whole bunch of shenanigans.

If however you want to install custom settings you can use any of the following:

```YAML
# Setup & Debugging
jar: # this is where my selenium server jar is
log: # the logs go to this folder

# Where to run your tests
host: 'localhost' # local, a grid ip or "saucelabs"
port:

# Browser
browser:      'firefox'
browser_path:
profile_path:
profile_name:

# Saucelabs
sauce_username: 'test_user_name'
sauce_api_key:
api_timeout: #how many seconds we should try to get the assets (default 10)
os:
browser_version:
description: #sauce job/test description
# set any sauce options below, they will override those above
sauce_opts:
    selenium_version: #default is 2.33.0
    os:
    browser_version:
    job_name: #sauce job/test description

```

You can pass parameters into the new config object like:

    config = SeleniumConnect::Configuration.new host: 'sauce labs', log: 'build'

Or you can load them up from a YAML file:

    config = SeleniumConnect::Configuration.new.populate_with_yaml '/my/config.yaml'


###Additional Configuration
When you create your job you can pass in parameters, right now just `:name` that lets you configure a job at runtime. This is helpful for using Sauce Labs where you'd want to update the description to whatever test job you are running:


```Ruby
#…
job.start name: 'website should load', sauce_opts: { public: 'team' }
#…
```

Note you can also pass a hash of `sauce_opts` to the job start function that will let you do additional run time configuration with options as detailed here: [https://saucelabs.com/docs/additional-config](https://saucelabs.com/docs/additional-config)


Similarly, when you finish your job you can pass in parameters. You can use the `failshot` parameter to turn on the saving of the last screenshot. For SauceLabs you can mark the tests as passed or failed:

```Ruby
# sweet your test passed!
report = job.finish passed: true

# shucks your test failed :(
report = job.finish failed: true, failshot: true
```

The `report` is simply a container for arbitrary data. Right now we are passing back the sauce details. Here is an example of `report.data` for a failed job:

```
{:assets=>{:server_log=>"failed_serverlog_failing_sauce_job_3ee1fddf4032476fa3f9de94298766ae.log", :job_data_log=>"failed_saucejob_failing_sauce_job_3ee1fddf4032476fa3f9de94298766ae.log"}, :sauce_data=>{:id=>"3ee1fddf4032476fa3f9de94298766ae", :"custom-data"=>nil, :owner=>"testing_arrgyle", :status=>"in progress", :error=>nil, :name=>"failing_sauce_job", :browser=>"iexplore", :browser_version=>"7.0.5730.13", :os=>"Windows 2003", :creation_time=>1373916900, :start_time=>1373916901, :end_time=>0, :video_url=>"http://saucelabs.com/jobs/3ee1fddf4032476fa3f9de94298766ae/video.flv", :log_url=>"http://saucelabs.com/jobs/3ee1fddf4032476fa3f9de94298766ae/selenium-server.log", :public=>nil, :tags=>[], :passed=>false}}
```

## Contribution Guidelines

This project conforms to the [neverstopbuilding/craftsmanship](https://github.com/neverstopbuilding/craftsmanship) guidelines. Specifically related to the branching model and versioning. Please see the guidelines for details.

### Install Dependencies

    bundle install

### Run the Tests!

```
rake              # defaults to 'build' task, code quality, unit, and integration tests
rake unit         # unit tests
rake integration  # integration tests
rake system       # system tests
```

### Or get your Guard On!

Running:

    guard

Will start watching the code and run the unit tests on save. Cool.

## Deployment
The release process is rather automated, just use one rake task with the new version number:

    rake release_start['2.1.0']

And another to finish the release:

    rake release_finish['A helpful tag message that will be included in the gemspec.']

This handles updating the change log, committing, and tagging the release.

## Friends

Below you can find some honorable mentions of those friends that are using Selenium Connect:

![image](http://d14f1fnryngsxt.cloudfront.net/images/logo/animotologotext_f78c60cbbd36837c7aad596e3b3bb019.svg)

We are proud that [Animoto](http://animoto.com/) uses Selenium Connect to help them test their awesome web app.
