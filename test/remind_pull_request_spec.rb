
require 'minitest/autorun'
require './lib/remind_pull_request'
require 'yaml'

class RemindPullRequestTest < Minitest::Test
  class GitHub
    def pulls(repo, options = {})
      []
    end
  end

  class Slack
    def chat_postMessage(options)
    end
  end

  def test_it_returns_text
    github = RemindPullRequestTest::GitHub.new
    slack = RemindPullRequestTest::Slack.new
    channel = 'channel'
    repo = 'repo'
    @remind = RemindPullRequest.new(github, slack, channel, repo)

    pull_request_1 = PullRequest.new
    pull_request_1.title = 'タイトル'
    pull_request_1.url = 'https://example.com'
    pull_request_1.requested_reviewers = ['hoge', 'fuga']
    pull_request_1.approvers = ['fuga']
    pull_request_2 = pull_request_1.dup

    text = <<~TEXT
      *Pending review on repo*
      <https://example.com|タイトル>
      waiting on: @hoge
      <https://example.com|タイトル>
      waiting on: @hoge
    TEXT
    assert_equal text, @remind.build_text([pull_request_1, pull_request_2])
  end
end
