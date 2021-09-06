class CollectPullRequest
  def initialize(github, settings)
    @github = github
    @settings = settings
  end

  def run
    @settings.each do |setting|
      setting['pull_requests'] = pull_requests(setting['repo'])
    end

    @settings
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
