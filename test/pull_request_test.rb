
require 'minitest/autorun'
require './lib/pull_request'

class PullRequestTest < Minitest::Test
  class GitHub
    def pull_request_reviews(repo, pr_number)
      []
    end

    def user(login)
    end
  end

  def setup
    @github = PullRequestTest::GitHub.new
  end

  def test_it_returns_mentions
    @pull_request = PullRequest.new(@github, requested_reviewers: ["hoge"])
    assert_equal ["@hoge"], @pull_request.mentions
  end

  def test_it_returns_remaining_reviewers
    @pull_request = PullRequest.new(@github, requested_reviewers: ["hoge"])
    assert_equal ["hoge"], @pull_request.remaining_reviewers
  end

  def test_it_returns_approvers
    @pull_request = PullRequest.new(@github)
    assert_equal [], @pull_request.approvers("repo", 0)
  end

  def test_it_returns_title
    @pull_request = PullRequest.new(@github, title: "タイトル")
    assert_equal "タイトル", @pull_request.title
  end

  def test_it_returns_url
    @pull_request = PullRequest.new(@github, url: "https://example.com")
    assert_equal "https://example.com", @pull_request.url
  end
end
