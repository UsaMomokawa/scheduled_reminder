class ConfigPullRequest
  def initialize(github, configs = [])
    @github = github
    @configs = configs
  end

  def set
    @configs.each do |config|
      config['pull_requests'] = pull_requests(config['repo'])
    end

    @configs
  end

  private

    def pull_requests(repo)
      waiting_for_review(repo).map do |w|
        PullRequest.new(
          @github,
          repo: repo,
          title: w.title,
          url: w.html_url,
          number: w.number,
          requested_reviewers: w.requested_reviewers.map(&:login)
        )
      end
    end

    def waiting_for_review(repo)
      @github.pulls(repo, state: 'open')
            .select { |pull| pull.labels.map(&:name).include?(ENV['PR_LABEL']) }
    end
end
