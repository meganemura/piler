require 'octokit'
module Piler
  class Client
    attr_reader :octokit

    def initialize(access_token:)
      @access_token = access_token
    end

    def octokit
      @octokit ||= Octokit::Client.new(access_token: access_token)
    end

    def access_token
      @access_token ||= ENV['PILER_GITHUB_TOKEN']
    end
  end
end
