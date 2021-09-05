
require 'minitest/autorun'
require './lib/remind_pull_request'

class RemindPullRequestTest < Minitest::Test
  class GitHub
    def pulls(repo, options = {})
      []
    end
  end

  def test_it_returns_text
    client = RemindPullRequestTest::GitHub.new
    remind = RemindPullRequest.new(client)
    assert_equal "", remind.run
  end
end
