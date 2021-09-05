require './lib/pull_request'

class RemindPullRequest
  def initialize(github, slack, channel, repo)
    @github = github
    @slack = slack
    @channel = channel
    @repo = repo
  end

  def run
    pull_requests = waiting_for_review.map do |w|
      pull_request = PullRequest.new
      pull_request.title = w.title
      pull_request.url = w.html_url
      pull_request.requested_reviewers = w.requested_reviewers.map(&:login)
      pull_request.approvers = approvers(w.number)

      pull_request
    end

    if pull_requests.empty?
      nil
    else
      text = pull_requests.map(&:text).join
      @slack.chat_postMessage(channel: @channel, text: text)
    end
  end

  private

    def waiting_for_review
      @github.pulls(@repo, state: 'open')
             .select { |pull| pull.labels.map(&:name).include?(ENV['PR_LABEL']) }
    end

    def approvers(pr_number)
      approves = @github.pull_request_reviews(@repo, pr_number)
                        .select { |review| review.state == 'APPROVED' }
      approves.empty? ? [] : approvers.map { |ap| ap.user.login }
    end
end
