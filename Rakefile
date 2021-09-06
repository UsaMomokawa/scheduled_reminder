require 'yaml'
require 'octokit'
require 'slack-ruby-client'
require 'dotenv'
Dotenv.load

desc 'remind pull request'
task :remind_pull_request do
  require './lib/collect_pull_request'
  require './lib/remind_pull_request'

  github = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
  slack = Slack::Web::Client.new(token: ENV['SLACK_BOT_TOKEN'])
  settings = File.open('settings.yml') { |io| YAML.load_stream(io) }

  collect = CollectPullRequest.new(github, settings).run
  RemindPullRequest.new(slack, collect).run
end
