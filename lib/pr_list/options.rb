module DevTools
  module PRlist
    class OptParse

      def self.default_options
        {
          verbose: 1,
          queue: false
        }
      end

      def self.validate_options
        raise RuntimeError, "Missing configuration file" if Options.nil?
        raise RuntimeError, "Missing authentication token" if Options.token.nil?
        raise RuntimeError, "No repositories provided" if Options.repos.empty?
      end

      def self.parse(argv_opts = [], unit_testing = false)
        opt_parse = DevTools::OptParse.new({ name:     IDENT,
                                             version:  VERSION,
                                             defaults: default_options,
                                             testing:  unit_testing })

        parser = opt_parse.parser

        parser.banner = "Usage: #{DevTools::PROGRAM} [OPTIONS]"

        parser.separator ""
        parser.separator "[OPTIONS]"

        parser.on "--[no-]queue", "filters PRs into a queue list for QA (default)" do |opt|
          Options.queue = opt
        end

        parser.separator ""
        parser.separator "Common Options:"

        parser.parse!(argv_opts)

        validate_options unless unit_testing

        Options
      end

    end
  end
end
