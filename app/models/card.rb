class Card < ActiveRecord::Base

  def self.get_score(user, game_id)
    cards = Card.where(game_id: game_id, user: user)
    cards.collect(&:value)
  end

  def get_value
    case value
    when 'A'
      11
    when 'K', 'Q', 'J'
      10
    else
      value.to_i
    end
  end

end
