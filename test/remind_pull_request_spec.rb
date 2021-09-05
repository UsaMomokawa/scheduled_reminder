
require 'minitest/autorun'
require './lib/remind_pull_request'

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
    remind = RemindPullRequest.new(github, slack)
    assert_equal nil, remind.run
  end
end
