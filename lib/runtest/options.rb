module RunTest
  class OptParse
    #
    # Return a structure describing the options.
    #
    def self.parse(args, unit_testing=false)
      # The options specified on the command line will be collected in *options*.
      # We set default values here.
      option_parser = DevTools::Options.new RunTest::PROGRAM_NAME, RunTest::VERSION, unit_testing

      parser  = option_parser.parser
      options = option_parser.options

      options.basedir = "src/js"
      options.changed = false
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

      parser.banner = "Usage: #{DevTools::PROGRAM} [OPTIONS] [PATTERN]"
      parser.banner += "\n\nWhere [PATTERN] is any full or partial filename."
      parser.banner += " All tests matching this filename pattern will be run."

      parser.separator ""
      parser.separator "[OPTIONS]"

      parser.separator ""
      parser.separator "Specific options:"

      # Base directory
      parser.on("-b", "--basedir DIR", "Specify the base directory to search for tests (DEFAULT: '#{options.basedir}')") do |dir|
        options.basedir = dir
      end

      # Changed switch
      parser.on("-c", "--changed", "Run specs for any files that have recently been modified") do
        options.changed = true
      end

      parser.separator ""
      parser.separator "Test Runners:"

      parser.on("-j", "--[no-]jest", "Only/Don't run Jest tests") do |jest|
        options.jest = true; options.mocha = false
        (options.jest = false; options.mocha = true) unless jest
      end

      parser.on("-m", "--[no-]mocha", "Only/Don't run Mocha tests") do |mocha|
        options.jest = false; options.mocha = true
        (options.jest = true; options.mocha = false) unless mocha
      end

      parser.separator ""
      parser.separator "Test Commands:"

      parser.on("--diff-cmd CMD", "Overwrite git diff command: '#{options.cmd[:git][:diff]}'") do |cmd|
        options.cmd[:git][:diff] = cmd
      end

      parser.on("--jest-cmd CMD", "Overwrite Jest command: '#{options.cmd[:jest]}'") do |cmd|
        options.cmd[:jest] = cmd
      end

      parser.on("--mocha-cmd CMD", "Overwrite Mocha command: '#{options.cmd[:mocha]}'") do |cmd|
        options.cmd[:mocha] = cmd
      end

      parser.separator ""
      parser.separator "Common Options:"

      parser.parse!(args)

      return options
    end
  end # class OptParse
end # module RunTest

