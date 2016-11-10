module QAqueue
  class OptParse

    def self.default_options
      {
        verbose: 1
      }
    end

    def self.validate_options
      raise RuntimeError, "Missing configuration file"   if Options.nil?
      raise RuntimeError, "Missing authentication token" if Options.token.nil?
      raise RuntimeError, "No repositories provided"     if Options.repos.empty?
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

      parser.separator ""
      parser.separator "Common Options:"

      parser.parse!(argv_opts)

      validate_options
    end

  end
end

