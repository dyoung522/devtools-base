module RunTest
  class OptParse
    require "optparse"
    require "ostruct"

    #
    # Return a structure describing the options.
    #
    def self.parse(args)
      # The options specified on the command line will be collected in *options*.
      # We set default values here.
      options         = OpenStruct.new
      options.basedir = "src/js"
      options.cmd     = {
        jest:  "$(npm bin)/jest",
        mocha: "$(npm bin)/mocha --require src/js/util/test-dom.js --compilers js:babel-core/register",
        git:   {
          diff: "git diff --name-only develop src/js | egrep \".js$\""
        }
      }
      options.jest    = true
      options.mocha   = true
      options.verbose = 0

      OptionParser.new do |opts|
        opts.banner = "Usage: #{File.basename(DevTools::PROGRAM)} [OPTIONS] [PATTERN]"
        opts.banner += "\n\nWhere [PATTERN] is any full or partial filename."
        opts.banner += " All tests matching this filename pattern will be run."

        opts.separator ""
        opts.separator "[OPTIONS]"

        opts.separator ""
        opts.separator "Specific options:"

        # Base directory
        opts.on("-b", "--basedir DIR", "Specify the base directory to search for tests (DEFAULT: '#{options.basedir}')") do |dir|
          options.basedir = dir
        end

        # Changed switch
        opts.on("-c", "--changed", "Run specs for any files that have recently been modified") do
          options.changed = true
        end

        # Verbose switch
        opts.on("-q", "--quiet", "Run quietly") do
          options.verbose = 0
        end

        opts.on("-v", "--verbose", "Run verbosely (may be specified more than once)") do
          options.verbose += 1
        end

        opts.separator ""
        opts.separator "Test Runners:"

        opts.on("-j", "--[no-]jest", "Only/Don't run Jest tests") do |jest|
          options.jest = true; options.mocha = false
          (options.jest = false; options.mocha = true) unless jest
        end

        opts.on("-m", "--[no-]mocha", "Only/Don't run Mocha tests") do |mocha|
          options.jest = false; options.mocha = true
          (options.jest = true; options.mocha = false) unless mocha
        end

        opts.separator ""
        opts.separator "Test Commands:"

        opts.on("--diff-cmd CMD", "Overwrite git diff command: '#{options.cmd[:git][:diff]}'") do |cmd|
          options.cmd[:git][:diff] = cmd
        end

        opts.on("--jest-cmd CMD", "Overwrite Jest command: '#{options.cmd[:jest]}'") do |cmd|
          options.cmd[:jest] = cmd
        end

        opts.on("--mocha-cmd CMD", "Overwrite Mocha command: '#{options.cmd[:mocha]}'") do |cmd|
          options.cmd[:mocha] = cmd
        end

        opts.separator ""
        opts.separator "Common options:"

        opts.on("-h", "--help", "Show this message") do
          puts version + "\n"
          puts opts
          exit
        end

        opts.on("-V", "--version", "Show version") do
          puts version
          exit
        end

      end.parse!(args)

      return options
    end

    # self.parse()

    def self.version
      sprintf "%s - v%s\n", RunTest::PROGRAM_NAME, RunTest::VERSION
    end

  end # class OptParse
end # module RunTest

