module Piler
  class Project
    attr_reader :client
    attr_reader :project

    def initialize(client, project)
      @client = client
      @project = project
    end

    def name
      project.name
    end

    def number
      project.number
    end

    def columns
      @columns ||= client.project_columns(project.id).map do |column|
        Column.new(client, column)
      end
    end

    def create_column(name)
      column = client.create_project_column(project.id, name)
      Column.new(client, column)
    end
  end
end
