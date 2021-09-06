
require 'minitest/autorun'
require './lib/collect_pull_request'

class CollectPullRequestTest < Minitest::Test
  class GitHub
    def pulls(repo, options = {})
      []
    end
  end

  def test_it_returns_array
    github = CollectPullRequestTest::GitHub.new
    settings = [{'channel' => 'general', 'repo' => 'user/repo'}]
    collect = CollectPullRequest.new(github, settings)

    array = [{'channel' => 'general', 'repo' => 'user/repo', 'pull_requests' => []}]
    assert_equal array, collect.run
  end
end
