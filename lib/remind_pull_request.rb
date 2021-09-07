require './lib/pull_request'

class RemindPullRequest
  def initialize(slack, configs)
    @slack = slack
    @configs = configs
  end

  def run
    @configs.each do |config|
      next if config['pull_requests'].empty?

      @slack.chat_postMessage(channel: config['channel'], text: build_text(config))
    end
  end

  def build_text(config)
    text = "*Pending review on #{config['repo']}*\n"

    config['pull_requests'].each do |pull_request|
      text += <<~TEXT
        <#{pull_request.url}|#{pull_request.title}>
        waiting on: #{pull_request.mentions(@slack).join(', ')}
      TEXT
    end

    text
  end
end
