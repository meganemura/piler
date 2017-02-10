require 'octokit'
require 'forwardable'
module Piler
  class Client
    extend Forwardable
    %i(
      projects
      project_columns
      column_cards
      create_project_column
      create_project_card
    ).each do |client_method|
      delegate client_method => :octokit
    end

    attr_reader :octokit

    def initialize(access_token: nil)
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
