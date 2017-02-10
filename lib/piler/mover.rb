module Piler
  class Mover
    attr_reader :repo
    attr_reader :from
    attr_reader :to
    attr_reader :client

    def initialize(repo, from, to)
      @client = Client.new
      @repo = repo
      @from = from
      @to = to
    end

    def move(dry_run: false)
      copy_columns(dry_run: dry_run)
      delete_project unless dry_run
    end

    def copy_columns(dry_run: false)
      puts "#{from_project.name} -> #{to_project.name}"
      from_project.columns.each do |from_column|
        puts "  Copy #{from_column.name}"

        column_name = "#{from_project.name}/#{from_column.name}"

        to_column = to_project.create_column(column_name) unless dry_run

        from_column.cards.each do |from_card|
          puts "    * #{from_card.card.note}"
          next if dry_run

          to_column.create_card(from_card)
        end
      end
    end

    def delete_project
      # TODO
    end

    def from_project
      @from_project ||= projects.find { |project| project.number == from }
    end

    def to_project
      @to_project ||= projects.find { |project| project.number == to }
    end

    def projects
      @projects ||= client.projects(repo).map do |project|
        Project.new(client, project)
      end
    end
  end
end
