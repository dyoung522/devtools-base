require "optparse"
require "ostruct"

module DevTools
  class Options
    attr_accessor :options
    attr_reader :parser, :version

    def initialize(name, version, unit_testing)
      @options ||= OpenStruct.new
      @parser  ||= common_options unit_testing
      @version ||= sprintf "%s - v%s\n", name, version
    end

    def common_options(unit_testing = false)
      options.verbose = 0

      OptionParser.new do |opts|
        opts.on_tail("-h", "--help", "Show this message") do
          unless unit_testing
            puts version + "\n"
            puts opts
            exit
          end
        end

        # Verbose switch
        opts.on_tail("-q", "--quiet", "Run quietly") do
          options.verbose = 0
        end

        opts.on_tail("-v", "--verbose", "Run verbosely (may be specified more than once)") do
          options.verbose += 1
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
