module QAqueue
  class PullRequest
    attr_reader :date, :number, :repo, :state, :title

    def initialize(issue, status)
      @date   = issue.created_at
      @number = issue.number
      @title  = issue.title

      @label = status[:label]
      @repo  = status[:repo]
      @state = status[:state]
    end
  end

  class PullRequests
    def initialize
      @pulls = []
    end

    def add(issues, status)
      issues.each { |issue| @pulls.push PullRequest.new issue, status }
    end

    def by_date
      @pulls.sort_by { |pr| pr.date }.each { |pr| yield pr }
    end

    def repos
      @pulls.collect { |pr| pr.repo }.uniq
    end

  end
end

