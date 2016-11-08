require "devtools"

module JIRADiff
  class OptParse

    def self.default_options
      {
        debug:     false,
        directory: ".",
        dryrun:    false,
        master:    "master",
        source:    [],
        verbose:   true
      }
    end

    def self.parse(argv_opts = [], unit_testing = false)
      opt_parse = DevTools::OptParse.new({ name:     PROGRAM_NAME,
                                           version:  VERSION,
                                           testing:  unit_testing,
                                           defaults: default_options })

      parser = opt_parse.parser

      parser.banner = "Usage: #{DevTools::PROGRAM} [OPTIONS]"

      parser.separator ""
      parser.separator "[OPTIONS]"

      parser.separator ""
      parser.separator "Specific Options:"

      parser.on("-d", "--directory DIR", "Use DIR as our source directory") do |dir|
        dir = File.expand_path(dir.strip)
        if Dir.exist?(dir)
          Options.directory = dir
        else
          raise ArgumentError, "ENOEXIST: Directory does not exist -> #{dir}"
        end
      end

      parser.on("-m", "--master BRANCH", "Specify a master branch (default: master)") { |m| Options.master = m }
      parser.on("-s", "--source BRANCH",
                "Use BRANCH as the source to compare against (may be used more than once)") do |branch|
        Options.source << branch unless Options.source.include?(branch)
      end

      parser.separator ""
      parser.separator "Common Options:"

      parser.parse!(argv_opts)

      validate_options(Options)
    end

    def self.validate_options(opts)
      if opts.source.include?(opts.master)
        raise RuntimeError, "Source branches cannot include the master branch"
      end

      opts.source = ["develop"] if opts.source.empty?
      opts.master = "master" if opts.master.nil? || opts.master.strip == ""

      opts
    end

  end
end
