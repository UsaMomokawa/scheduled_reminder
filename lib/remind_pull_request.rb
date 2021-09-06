require './lib/pull_request'

class RemindPullRequest
  def initialize(slack, collect)
    @slack = slack
    @collect = collect
  end

  def run
    @collect.each do |co|
      next if co['pull_requests'].empty?

      @slack.chat_postMessage(channel: co['channel'], text: build_text(co))
    end
  end

  def build_text(co)
    text = "*Pending review on #{co['repo']}*\n"

    co['pull_requests'].each do |pull_request|
      text += <<~TEXT
        <#{pull_request.url}|#{pull_request.title}>
        waiting on: #{pull_request.mentions(@slack).join(', ')}
      TEXT
    end

    text
  end
end
