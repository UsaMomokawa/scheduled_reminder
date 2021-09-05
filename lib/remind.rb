require 'octokit'
require 'dotenv'
Dotenv.load
require './lib/remind_pull_request'

client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
puts RemindPullRequest.new(client).run
