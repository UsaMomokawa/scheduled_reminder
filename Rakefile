require 'yaml'
require 'octokit'
require 'slack-ruby-client'
require 'dotenv'
Dotenv.load

desc 'remind pull request'
task :remind_pull_request do
  require './lib/config_pull_request'
  require './lib/remind_pull_request'

  github = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
  slack = Slack::Web::Client.new(token: ENV['SLACK_BOT_TOKEN'])
  configs = File.open('config.yml') { |io| YAML.load_stream(io) }

  config = ConfigPullRequest.new(github, configs).set
  RemindPullRequest.new(slack, config).run
end
