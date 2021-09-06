class PullRequest
  attr_reader :title, :url
  def initialize(github, options = {})
    @github = github
    @repo = options[:repo] || ''
    @title = options[:title] || ''
    @url = options[:url] || ''
    @number = options[:number] || ''
    @requested_reviewers = options[:requested_reviewers] || []
  end

  def remaining_reviewers
    @requested_reviewers - approvers(@repo, @number)
  end

  def mentions(&block)
    remaining_reviewers.map do |reviewer|
      email = @github.user(reviewer)&.email
      if email
        '@<' + yield(email) + '>'
      else
        '@' + reviewer
      end
    end
  end

  def approvers(repo, pr_number)
    approves = @github.pull_request_reviews(repo, pr_number)
                      .select { |review| review.state == 'APPROVED' }
    approves.empty? ? [] : approvers.map { |ap| ap.user.login }
  end
end

