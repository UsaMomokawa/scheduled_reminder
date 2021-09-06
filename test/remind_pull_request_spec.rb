
require 'minitest/autorun'
require './lib/remind_pull_request'

class RemindPullRequestTest < Minitest::Test
  class Slack
    def chat_postMessage(options)
    end
  end

  class GitHub
    def pull_request_reviews(repo, pr_number)
      []
    end

    def user(login)
    end
  end

  def test_it_returns_text
    github = RemindPullRequestTest::GitHub.new
    pull_request = PullRequest.new(github,
      title: 'タイトル',
      url: 'https://example.com',
      requested_reviewers: ['hoge']
    )

    slack = RemindPullRequestTest::Slack.new
    @remind = RemindPullRequest.new(slack, {})

    text = <<~TEXT
      *Pending review on user/repo*
      <https://example.com|タイトル>
      waiting on: @hoge
    TEXT

    co = {'channel' => 'general', 'repo' => 'user/repo', 'pull_requests' => [pull_request]}
    assert_equal text, @remind.build_text(co)
  end
end
