# Encoding: utf-8

require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'flog_task'
require 'flay_task'
require 'reek/rake/task'

task default: :build

task build: [:clean, :prepare, :quality, :unit, :integration]

desc 'Runs standard build activities.'
#task build_full: [:clean, :prepare, :quality, :unit, :integration, :system]
task build_full: [:clean, :prepare, :unit, :integration, :system]

desc 'Runs quality checks.'
task quality: [:rubocop, :reek, :flog_total, :flog_average, :flay]

desc 'Removes the build directory.'
task :clean do
  FileUtils.rm_rf 'build'
  FileUtils.rm 'chromedriver.log' if File.exist? 'chromedriver.log'
  FileUtils.rm 'libpeerconnection.log' if File.exist? 'libpeerconnection.log'
end
desc 'Adds the build tmp directory for test kit creation.'
task :prepare do
  FileUtils.mkdir_p('build/tmp')
  FileUtils.mkdir_p('build/spec')
end

def get_rspec_flags(log_name, others = nil)
  "--format documentation --out build/spec/#{log_name}.log --format html --out build/spec/#{log_name}.html --format progress #{others}"
end

RSpec::Core::RakeTask.new(:unit) do |t|
  t.pattern = FileList['spec/unit/**/*_spec.rb']
  t.rspec_opts = get_rspec_flags('unit')
end

RSpec::Core::RakeTask.new(:integration) do |t|
  t.pattern = FileList['spec/integration/**/*_spec.rb']
  t.rspec_opts = get_rspec_flags('integration', '--tag=~selenium')
end

RSpec::Core::RakeTask.new(:system) do |t|
  t.pattern = FileList['spec/integration/**/*_spec.rb']
  t.rspec_opts = get_rspec_flags('system', '--tag selenium')
end

Rubocop::RakeTask.new

# TODO: lower the quality score and improve the code!
FlogTask.new :flog_total, 10000 do |t|
  t.method = :total_score
  t.verbose = true
end

# TODO: lower the quality score and improve the code!
FlogTask.new :flog_average, 100 do |t|
  t.method = :average
  t.verbose = true
end

# TODO: lower the quality score and improve the code!
FlayTask.new :flay, 10000 do |t|
  t.verbose = true
end

# TODO: fix all the smells and turn on failing on error
Reek::Rake::Task.new do |t|
    t.fail_on_error = false
    t.verbose = false
    t.reek_opts = '--quiet'
end

# TODO: This could probably be more cleanly automated
desc 'Start a release (Requires Git Flow)'
task :release_start, :version do |t, args|
  version = args['version']

  # make sure we have the latest stuff
  system 'git fetch --all'

  # first make sure master is checked out and up to date
  system 'git checkout master'
  system 'git pull --no-edit origin master'

  # then make sure develop is up to date
  system 'git checkout develop'
  system 'git pull --no-edit origin develop'

  # next assure all the tests run
  task(:build_full).invoke

  # start the release process
  system "git flow release start #{version}"

  # update the version number in the .gemspec file
  gemspec = File.join(Dir.getwd, 'selenium-connect.gemspec')
  updated = File.read(gemspec).gsub(
    /s.version(\s+)=(\s?["|']).+(["|'])/,
    "s.version\\1=\\2#{version}\\3"
  )
  File.open(gemspec, 'w') { |f| f.write(updated) }

  # commit the version bump
  system 'git add selenium-connect.gemspec'
  system "git commit -m 'Bumped version to #{version} to prepare for release.'"

  puts "You've started release #{version}, make any last minute updates now.\n"
end

# TODO This could probablly be more cleanly automated
desc 'Finish a release (Requires Git Flow and Gem Deploy Permissions'
task :release_finish, :update_message do |t, args|
  message   = args['update_message']
  gemspec   = File.join(Dir.getwd, 'selenium-connect.gemspec')
  changelog = File.join(Dir.getwd, 'CHANGELOG.md')
  version   = File.read(gemspec).match(/s.version\s+=\s?["|'](.+)["|']/)[1]
  readme = File.join(Dir.getwd, 'README.md')
  date = Time.new.strftime('%Y-%m-%d')

  ### Changelog
  # get the latest tag
  system 'git checkout master'
  last_tag = `git describe --abbrev=0`
  system "git checkout release/#{version}"
  # get the commit hash since the last that version was merged to develop
  hash = `git log --grep="Merge branch 'release/#{last_tag.chomp}' into develop" --format="%H"`
  # get all the commits since them less merges
  log = `git log --format="- %s" --no-merges #{hash.chomp}..HEAD`

  changelog_contents = File.read(changelog)
  # create the new heading
  updated_changelog = "##{version} (#{date})\n" + message + "\n\n" + log + "\n" + changelog_contents
  # update the contents
  File.open(changelog, 'w') { |f| f.write(updated_changelog) }
  puts "Updated change log for version #{version}\n"

  ### Update the gemspec with the message
  updated_gemspec = File.read(gemspec).gsub(
    /s.description(\s+)=(\s?["|']).+(["|'])/,
    "s.description\\1=\\2#{message}\\3"
  )
  File.open(gemspec, 'w') { |f| f.write(updated_gemspec) }

  ### Update the readme heading
  updated = File.read(readme).gsub(
    /^#selenium-connect \d+\.\d+.\d+ \(.+\)/,
    "#selenium-connect #{version} (#{date})"
  )
  File.open(readme, 'w') { |f| f.write(updated) }

  # Commit the updated change log and gemspec and readme
  system "git commit -am 'Updated CHANGELOG.md gemspec and readme heading for #{version} release.'"

  # build the gem
  system 'gem build selenium-connect.gemspec'

  # push the gem
  system "gem push selenium-connect-#{version}.gem"

  # remove the gem file
  system "rm selenium-connect-#{version}.gem"

  # finish the release
  # TODO there is a bug with git flow, and you still need to deal with merge
  # messages, might just do this with git directly
  system "git flow release finish -m'#{version}' #{version}"

  # push develop
  system 'git push origin develop'

  # push master
  system 'git push origin master'

  # push tags
  system 'git push --tags'

  puts "Rock and roll, you just released Selenium Connect #{version}!\n"
end
