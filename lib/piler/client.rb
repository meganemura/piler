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
      define_method client_method do |*args|
        if args.last.is_a?(Hash)
          args.last.update(accept: accept_header)
        else
          args << { accept: accept_header }
        end
        octokit.send(client_method, *args)
      end
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

    def accept_header
      'application/vnd.github.inertia-preview+json'
    end
  end
end
