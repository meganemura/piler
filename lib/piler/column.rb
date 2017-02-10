module Piler
  class Column
    attr_reader :client
    attr_reader :column

    def initialize(client, column)
      @client = client
      @column = column
    end

    def name
      column.name
    end

    def cards
      @cards ||= client.column_cards(column.id).map do |card|
        Card.new(client, card)
      end
    end

    def create_card(card)
      new_card = client.create_project_card(column.id, card.movable_fields)
      Card.new(client, new_card)
    end
  end
end
