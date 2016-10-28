require "config"
require "optparse"
require "ostruct"
require "pp"

module DevTools
  class OptParse
    attr_reader :parser, :version

    def initialize(opts, unit_testing = false)
      program_path  = DevTools::PROGRAM
      program_files = %W(~/.#{program_path} ./.#{program_path} ./#{program_path}.conf ./#{program_path}.rc)

      Config.setup do |config|
        config.const_name = 'Options'
        config.use_env    = true
      end

      Config.load_and_set_settings unit_testing ? "" : program_files
      Options.verbose = 0

      @parser  ||= common_options unit_testing
      @version ||= sprintf "%s - v%s\n", opts[:name] || DevTools::PROGRAM, opts[:version] || DevTools::VERSION
    end

    def common_options(unit_testing = false)
      OptionParser.new do |opts|
        opts.on_tail("-h", "--help", "Show this message") do
          unless unit_testing
            puts version + "\n"
            puts opts
            exit
          end
        end

        # Config file
        opts.on_tail("-c", "--config FILE", "Specify an alternate configuration file") do |file|
          Options.add_source! file
          Options.reload!
        end

        # Verbose switch
        opts.on_tail("-q", "--quiet", "Run quietly") do
          Options.verbose = 0
        end

        opts.on_tail("-v", "--verbose", "Run verbosely (may be specified more than once)") do
          Options.verbose += 1
        end

        opts.on_tail("--version", "Show version") do
          unless unit_testing
            puts version
            exit
          end
        end
      end
    end
  end # class Options
end # module DevTools
