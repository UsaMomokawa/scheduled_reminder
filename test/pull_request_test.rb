
require 'minitest/autorun'
require './lib/pull_request'

class PullRequestTest < Minitest::Test
  def setup
    @pull_request = PullRequest.new
  end

  def test_it_returns_title
    @pull_request.title = "タイトル"
    assert_equal "タイトル", @pull_request.title
  end

  def test_it_returns_url
    @pull_request.url = "https://example.com"
    assert_equal "https://example.com", @pull_request.url
  end

  def test_it_returns_remaining_reviewers
    @pull_request.requested_reviewers = ['hoge', 'fuga']
    @pull_request.approvers = ['fuga']
    assert_equal ['hoge'], @pull_request.remaining_reviewers
  end

  def test_it_returns_text
    @pull_request.title = 'タイトル'
    @pull_request.url = 'https://example.com'
    @pull_request.requested_reviewers = ['hoge', 'fuga']
    @pull_request.approvers = ['fuga']

    text = <<~TEXT
      <タイトル|https://example.com>
      waiting on: @hoge
    TEXT
    assert_equal text, @pull_request.text
  end
end
