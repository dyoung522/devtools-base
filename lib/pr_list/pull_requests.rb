require "octokit"

module DevTools
  module PRlist
    class PullRequest
      attr_reader :issue

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

      def repo(opt = {})
        opt[:short] = false unless opt.has_key?(:short)

        /repos\/(\w*\/?(.*))$/.match(@issue.repository_url)[opt[:short] ? 2 : 1]
      end
    end

    class PullRequests
      attr_reader :pulls

      def initialize(token = nil, repos = [])
        @pulls  ||= []
        @github ||= __authenticate token

        repos.each { |repo| load!(repo) } if authorized?
      end

      def authorized?
        return !@github.nil?
      end

      def auth!(token)
        @github = __authenticate token
      end

      def load!(repo)
        raise NoAuthError, "You must authorized with github using #auth first" unless authorized?

        @github.issues(repo).each do |issue|
          __load_issue issue if issue.pull_request?
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

      def __load_issue(issue)
        @pulls.push PullRequest.new issue
      end

      def __authenticate(token)
        token ? Octokit::Client.new(access_token: token) : nil
      end

    end
  end
end
