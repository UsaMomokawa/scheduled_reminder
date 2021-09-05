require 'octokit'
require 'slack-ruby-client'
require 'dotenv'
Dotenv.load
require './lib/remind_pull_request'

github = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
slack = Slack::Web::Client.new(token: ENV['SLACK_BOT_TOKEN'])
puts RemindPullRequest.new(github, slack).run

