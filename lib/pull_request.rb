class PullRequest
  attr_accessor :title, :url, :remaining_reviewers
  def initialize
    @title = ''
    @url = ''
    @remaining_reviewers = []
  end

  def text
    remaining_reviewers = @remaining_reviewers.map { |r| '@' + r }.join(', ')

    text = <<~TEXT
      <#{@title}|#{@url}>
      waiting on: #{remaining_reviewers}
    TEXT
  end
end

