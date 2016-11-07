require "jira_diff/globals"
require "jira_diff/options"
require "jira_diff/stories"

module JIRADiff
  def self.not_implemented(feature)
    puts "Sorry, #{feature} has not yet been implemented"
    exit 2
  end

  def self.run!
    begin
      opts = OptParse.parse ARGV
    rescue => error
      puts error
      exit 1
    end

    puts opts.inspect if opts.debug

    begin
      puts 'Searching for stories...' if opts.verbose
      stories = Stories.new(opts)
    rescue RuntimeError => error
      puts error
      exit 1
    end

    if opts.verbose
      puts "From #{stories.directory}"
      puts "-> All stories from #{stories.source.join(', ')}"
      puts "-> Which are not in #{stories.master}"
      stories.diff.each do |story|
        puts "%-120.120s" % story.to_s
      end
    else
      puts stories.diff.shas
    end

  end

end

