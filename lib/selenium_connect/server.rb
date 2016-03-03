# Encoding: utf-8

# selenium connect
class SeleniumConnect
  # Creates a server connection
  class Server
    attr_reader :configuration, :current_dir_path

    def initialize(configuration)
      @configuration = configuration
      @current_dir_path = File.join(File.dirname(File.expand_path(__FILE__)))
    end

    def start
      rake 'start'
    end

    def stop
      rake 'stop'
    end

    def restart
      rake 'restart'
    end

    private

      def get_rake_file
        rake_file_path = current_dir_path + '/rake.task'
        File.open(rake_file_path, 'w') do |file|
          file.puts "require 'selenium/rake/server_task'"
          file.puts 'Selenium::Rake::ServerTask.new(:server) do |t|'
          if configuration.jar
            file.puts "t.jar = '#{configuration.jar}'"
          else
            file.puts "t.jar = '#{current_dir_path + '/../../bin/selenium-server-standalone-2.41.0.jar'}'"
          end
          file.puts 't.background'
          if configuration.log
            file.puts "t.log = '#{File.join(Dir.getwd, configuration.log, 'server.log')}'"
          else
            file.puts 't.log = false'
          end
          file.puts "t.port = #{configuration.port}"
          opts = ''
          if configuration.browser == 'chrome'
            opts += '-Dwebdriver.chrome.driver=' + current_dir_path + '/../../bin/chromedriver'
            if configuration.log
              opts += ' -Dwebdriver.chrome.logfile=' + File.join(Dir.getwd, configuration.log, 'chrome.log')
            end
            file.puts "t.opts = %w[#{opts}]"
          end
          file.puts 'end'
        end
          rake_file_path
      end

    def rake(task)
      system "rake -f #{get_rake_file} server:#{task}"
    end

  end # Server
end # SeleniumConnect
