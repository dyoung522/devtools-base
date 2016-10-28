require 'ostruct'

module RunTest
  class OptParse
    #
    # Return a structure describing the Options.
    #
    def self.parse(args, unit_testing=false)
      # The Options specified on the command line will be collected in *Options*.
      # We set default values here.
      parser = DevTools::OptParse.new({ name: RunTest::PROGRAM_NAME, version: RunTest::VERSION }, unit_testing).parser

      Options.basedir        ||= "src/js"
      Options.changed        ||= false
      Options.commands       ||= OpenStruct.new
      Options.commands.diff  ||= "git diff --name-only develop src/js | egrep \".js$\""
      Options.commands.jest  ||= "$(npm bin)/jest"
      Options.commands.mocha ||= "$(npm bin)/mocha --require src/js/util/test-dom.js --compilers js:babel-core/register"
      Options.jest           ||= true
      Options.mocha          ||= true
      Options.verbose        ||= 0

      parser.banner = "Usage: #{DevTools::PROGRAM} [OPTIONS] [PATTERN]"
      parser.banner += "\n\nWhere [PATTERN] is any full or partial filename."
      parser.banner += " All tests matching this filename pattern will be run."

      parser.separator ""
      parser.separator "[OPTIONS]"

      parser.separator ""
      parser.separator "Specific Options:"

      # Base directory
      parser.on("-b", "--basedir DIR", "Specify the base directory to search for tests (DEFAULT: '#{Options.basedir}')") do |dir|
        Options.basedir = dir
      end

      # Changed switch
      parser.on("-c", "--changed", "Run specs for any files that have recently been modified") do
        Options.changed = true
      end

      parser.separator ""
      parser.separator "Test Runners:"

      parser.on("-j", "--[no-]jest", "Only/Don't run Jest tests") do |jest|
        Options.jest = true; Options.mocha = false
        (Options.jest = false; Options.mocha = true) unless jest
      end

      parser.on("-m", "--[no-]mocha", "Only/Don't run Mocha tests") do |mocha|
        Options.jest = false; Options.mocha = true
        (Options.jest = true; Options.mocha = false) unless mocha
      end

      parser.separator ""
      parser.separator "Test Commands:"

      parser.on("--diff-cmd CMD", "Overwrite git diff command: '#{Options.commands.diff}'") do |cmd|
        Options.commands.diff = cmd
      end

      parser.on("--jest-cmd CMD", "Overwrite Jest command: '#{Options.commands.jest}'") do |cmd|
        Options.commands.jest = cmd
      end

      parser.on("--mocha-cmd CMD", "Overwrite Mocha command: '#{Options.commands.mocha}'") do |cmd|
        Options.commands.mocha = cmd
      end

      parser.separator ""
      parser.separator "Common Options:"

      parser.parse!(args)

      return Options
    end
  end # class OptParse
end # module RunTest

