module Piler
  class Card
    attr_reader :client
    attr_reader :card

    def initialize(client, card)
      @client = client
      @card = card
    end

    def movable_fields
      if card.note
        {
          note: card.note,
        }
      else
        {
          content_id: card.content_id,
          content_type: card.content_type,
        }
      end
    end
  end
end
