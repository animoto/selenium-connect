#3.7.1 (2014-04-13)
Updated Selenium gems and binaries so they are current

- Bumped version to 3.7.1 to prepare for release.
- Side-stepping quality checks for now -- too many to sort out today. Will revisit next go-round
- Updated a the jar reference
- Updated dotfiles
- Updated chromedriver and phantomjs
- Updated selenium standalone server jar
- Added .DS_Store files to gitignore

#3.7.0 (2013-08-26)
Can now pass run time sauce options to a job and will capture all open window doms

- Bumped version to 3.7.0 to prepare for release.
- upgraded chromedriver and moved the tests to the right place
- updated tests and doc for additional configurations
- added the ability to pass in a hash of sauce opts to the job start array in order to set team permissions and what have
- first crack at multi window assets

#3.6.0 (2013-08-18)
upgraded selenium version and improved chrome log storage

- Bumped version to 3.6.0 to prepare for release.
- more code quality fixes
- code quality fixes
- cleaned up the server class a little and added sensible chrome log file saving to the jar so we don\'t move files around
- upgraded to newer version of jar file

#3.5.0 (2013-08-12)
updated selenium server jar and sauce version default plus screenshots and dom html for everyone

- Bumped version to 3.5.0 to prepare for release.
- updated documentation
- updated the sauce version of selenium server to 2.32, upgraded the local selenium server bin to 2.34, changed logfiles to be more readable, added the ability to grab the dom html and the non sauce screenshots on failure
- updated selenium server jar

#3.4.0 (2013-08-03)
Added more code quality tools and capture enhanced chrome logs

- Bumped version to 3.4.0 to prepare for release.
- fixed error with chrome processor
- added reek and a rake task and fixed on of the smell issues, leaving it only as warnings for now but we should fix the smells at some point
- added flog and updated rubocop version, fixed all quality issues, updated rake tasks for flog and rubocop
- moved development dependencies to gemfile to support git based repo for latest rubocop
- added a test for the chrome log files and also updated it to pull the libpeer log
- updated readme
- added animoto to the readme
- updated job finishing to move chrome log to evidence folder
- added advanced logs to the evidence directory

#3.3.1 (2013-07-24)
Fixed bug with the job naming

- Bumped version to 3.3.1 to prepare for release.
- fixed bug with job nameing per new configurations

#3.3.0 (2013-07-24)
updated configuration to support any sauce config and set default sauce selenium version

- Bumped version to 3.3.0 to prepare for release.
- updated the configuration object to support passing any arbitrary sauce configuration parameter while also supporting the original configurations for backwards compatibility, also setting a default selenium server version

#3.2.0 (2013-07-15)
added better error handling to the sauce api calls and improved naming convention for job assets

- Bumped version to 3.2.0 to prepare for release.
- cleaned up the way the job log was saving
- added one more error check around the sauce data
- refactored the log saving and sauce api access, now can configure the api time out and the requests will poll when trying to fetch the data from the server

#3.1.2 (2013-07-14)
removed references to curb

- Bumped version to 3.2.1 to prepare for release.
- removed references to curb
- removed curb as that is also not needed
- Update README.md

#3.1.1 (2013-07-14)
fixed a bug with the job id for non sauce tests

- Bumped version to 3.1.1 to prepare for release.
- fixed bug with an unset job id for non sauce runs

#3.1.0 (2013-07-14)
return the log file names in the report object

- Bumped version to 3.1.0 to prepare for release.
- now passing back the sauce job and log file name in the report data
- removed mocha from gemspec as it was not being used
- updated rakefile to include release message at the top of the changelog stuff

#3.0.0 (2013-07-14)
- updated rake file to run all the tests on a release start
- Bumped version to 3.0.0 to prepare for release.
- updated coverage badge in the docs and did a little ditty to jive gem name with proper file naming
- updated the build process to add the version number and date to the top of the readme on release so that people know how old the docs is #5
- updated documentation to reflect the changes in #5
- added a facility to download a job tagged failure image to the logs directory
- now sending a passed or failed bool in the finish command will mark sauce labs jobs as such #5
- major refactoring of public api per #5 and updating the tests to match
- added guard configuration and updated the coverage reports to go to the build directory #5
- added coveralls code coverage information #5
- added catch to rakefile for log deletions #5
- updated tests for new support files location, cleaned up build process adding good logging and seperation of unit, integration, and system tests #5
- moved specs into standard format, updated names to standard class file name convention #5
- fixed some minor code quality issues

#2.3.0 (2013-07-12)
- removed debug information from the sauce_spec
- Bumped version to 2.3.0 to prepare for release.
- SeleniumConnect.finish now returns a hash of arbitrary data, which at this time contains sauce labs job information, for those runs

#2.2.0 (2013-07-08)
- Bumped version to 2.2.0 to prepare for release.
- updated tests and log namming to account for possible parallel usage
- added test and fixed the log path
- first cut of grabbing the server log from sauce labs after a job

#2.1.1 (2013-07-04)
- Updated rakefile to propperly fetch the previous version for changelog purposes
- Bumped version to 2.1.1 to prepare for release.
- fixed bug with the server shutdown process and improved the exception handling for invalid configuration parameters
- updated changelog

#2.1.0 (2013-07-02)
- Updated configuration method
- Code quality fixes

#2.0.0 (2013-06-27)
- Added selenium server jar as explicit dependency
- Updated ruby version
- Updated logging tests

#1.9.3 (2013-06-21)
- Merge branch 'release/1.9.3'
- Bumping to 1.9.3 since rubygems is giving me guff about 1.9.2 already existing, even though the upload failed halfway through.
- Merge branch 'release/1.9.2' into develop
- Merge branch 'release/1.9.2'
- Bumped version and description
- Nefarious. Tests passed running in this dir but failed in the wild. Needed to incorporate Dir.getwd into the mix to capture log output properly.
- Merge branch 'release/1.9.1'
- Bumped to 1.9.1
- Removed the rake task from the repo since it is dynamically generated
- Refactored the test structure so it is not redundant and assertions are separated.
- Cleaned up some cruft
- Added rake tasks to gitignore
- Removed the default setter for logs since this is covered in the local server runner
- Added .gem to the gitignore
- Merge branch 'release/1.9.0'
- Bumped version number to 1.9.0 and added description
- Added a build dir with a shadow file so it stays put on github (for future committers to run tests without setup). Broke out the specs into separate files since they were getting a bit long in the tooth. Reworked the PhantomJS runner so it works with the existing Remote pattern matching after adding the requisite phantomjs binary to the project bin dir and adding the necessary capabilities in the runner.
- removed chromedriver.log
- started fleshing out a more consolidated log folder and option for such, got the firefox to output its log file to that folder.
- back merged master into develop to keep inline with git flow, added a blank changelog file and minor tweeks to the docs
- Merge branch 'master' into develop
- Merge pull request #4 from arrgyle/feature/headless
- added a phantomjs browser with spec
- Set sauce gem version to pre-3 since new version is causing hiccups to do a new dependency, and potentially other lurking breaking changes

#1.8.0 (2013-05-28)
- Bumped to version 1.8.0
- Added better chrome support by adding the chromedriver to bin. Setting browser to chrome and host to localhost will run things locally now via the remote webdriver.
- Bumped version to 1.7 for yaml config support

#1.7.0 (2013-05-22)
- Initial pass on adding yaml config file support

#1.6.0 (2013-05-15)
- Bumped version number and updated description
- Added sauce to support list
- Removed un-needed require from test
- Initial assumptions of the location being needed for sauce and localhost were proven false since the sauce gem actually instantiates a driver object. So, backed out the location stuff and added saucelabs as a runner.
- Chased down a bug where configs were not getting passed properly. This was due to an overzealous find replace made earlier today. Fixed.
- Things are stubbed -- test has basic config hooks I want to pass, and the code is abstracted and waiting for sauce gem specific bits. Splunkingi through their code now.
- Abstracted out location checking and execution for easy extension to account for local server runs and sauce labs integration.
- Removed a rogue puts, and tested logging fix (which was addressed in previous commit). Fixes #3
- Refactoring complete for browser selection
- Added missing requires
- Added Chrome and NoBrowser objects. Initial attempt at refactoring to remove the case statement in runner.
- Fixed a bug in the firefox binary path setter, and bumped the version to 1.5.1

#1.5.0 (2013-05-13)
- Bumped version to 1.5.0
- Added firefox binary path as a config parameter for local testing.

#1.4.0 (2013-05-10)
- Added IE support and abstracted the firefox and ie runners into a runner directory.
- Updated spec for some pending actions
- *sigh* I always forget the -a
- Abstracted Firefox functionality out into its own class within Runner. Also added scaffolding for IE support. Lastly, fixed a bug by removing a hard-code dependency to the Remote::Bridge class which was done based on a faulty assumption.
- Minor tweak to the readme

#1.3.0 (2013-05-09)
- Bumping version to 1.3.0
- Added a test for logging, and updated the server to properly wrap the logging parameter on rake task creation -- fixes #2. Also caught a bug introduced with the previous profile commit -- fixed with a small nil check.
- Added profile name selection for firefox and cleaned up the tests a bit. Also fixed the default configuration params setter, fixes #1
- Ported example.rb into an RSpec spec, and added rspec as a development dependency in the gemspec
- Removed Gemfile.lock from the repo per recommendations from jwieringa and radar in https://github.com/arrgyle/chemistrykit/pull/14
- Got schooled by Jim Gay that == returns true or false, so no ternary or then action required. Hella simplified.
- Switched out the if/then in localhost? to a ternary operator
- Merge branch 'master' of https://github.com/arrgyle/selenium-connect
- Simplified the localhost method based on Jim Gay's feedback
- Bumping badget to the right of the title
- Adding Code Climate badge.
- Bumped version for bug fix
- Moved sensible defaults setting from runner into configuration
- Renamed all of the bits to selenium-connect
- Sanitizing.

#v.1.2.0 (2013-04-18)

#1.1.0 (2013-04-18)

#1.0.0 (2013-04-18)
- Initial Release
