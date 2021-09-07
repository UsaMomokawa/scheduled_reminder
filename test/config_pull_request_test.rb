
require 'minitest/autorun'
require './lib/config_pull_request'

class ConfigPullRequestTest < Minitest::Test
  class GitHub
    def pulls(repo, options = {})
      []
    end
  end

  def test_it_returns_array
    github = ConfigPullRequestTest::GitHub.new
    base = [{'channel' => 'general', 'repo' => 'user/repo'}]
    config = ConfigPullRequest.new(github, base)
    array = [{'channel' => 'general', 'repo' => 'user/repo', 'pull_requests' => []}]
    assert_equal array, config.set
  end
end
