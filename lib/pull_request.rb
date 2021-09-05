class PullRequest
  attr_accessor :title, :url, :requested_reviewers, :approvers
  def initialize
    @title = ''
    @url = ''
    @requested_reviewers = []
    @approvers = []
  end

  def remaining_reviewers
    requested_reviewers - approvers
  end

  def text
    mentions = remaining_reviewers.map { |r| '@' + r }.join(', ')

    text = <<~TEXT
      <#{@url}|#{@title}>
      waiting on: #{mentions}
    TEXT
  end
end

