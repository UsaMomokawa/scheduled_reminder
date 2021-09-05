require 'dotenv'
Dotenv.load
require './lib/pull_request'

class RemindPullRequest
  def initialize(github, slack)
    @github = github
    @slack = slack
    @pull_requests = []
  end

  def run
    @pull_requests = waiting_for_review.map do |w|
      pull_request = PullRequest.new
      pull_request.title = w.title
      pull_request.url = w.url
      pull_request.requested_reviewers = w.requested_reviewers.map(&:login)
      pull_request.approvers = approvers(w.number)

      pull_request
    end

    text = if @pull_requests.empty?
      ""
    else
      @pull_requests.map(&:text).join('\n')
    end
  end

  private

    def waiting_for_review
      @github.pulls(ENV['REPO'], state: 'open')
    end

    def approvers(pr_number)
      approves = @github.pull_request_reviews(ENV['REPO'], pr_number)
                        .select { |review| review.state == 'APPROVED' }
      approves.empty? ? [] : approvers.map { |ap| ap.user.login }
    end
end
