require "octokit"

module QAqueue
  attr_reader :issue

  class PullRequest
    def initialize(issue)
      @issue ||= issue
    end

    def date
      @issue.created_at
    end

    def number
      @issue.number
    end

    def title
      @issue.title
    end

    def labels
      @issue.labels.map { |l| l.name }
    end

    def repo(full = false)
      /repos\/(\w*\/?(.*))$/.match(@issue.repository_url)[full ? 1 : 2]
    end
  end

  class PullRequests
    def initialize(token = nil)
      @pulls  ||= []
      @github ||= __authenticate(token)
    end

    def auth!(token)
      @github = __authenticate(token)
    end

    def load!(repo)
      raise NoAuthError, "You must authorized with github using #auth first" unless @github

      @github.issues(repo).each do |issue|
        @pulls.push PullRequest.new issue if (issue.pull_request && issue.pull_request.url)
      end
    end

    def by_date
      sorted_pulls = @pulls.sort_by { |pr| pr.date }

      block_given? ? sorted_pulls.each { |pr| yield pr } : sorted_pulls
    end

    def repos
      @pulls.collect { |pr| pr.repo }.uniq
    end

    private

    def __authenticate(token)
      token ? Octokit::Client.new(access_token: token) : nil
    end

  end
end

