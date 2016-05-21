class Game

  attr_reader :id, :player_cards, :dealer_cards, :player_score, :dealer_score, :winner
  
  USER = {:player => 1, :dealer => 2}
  

  def initialize(id=nil)
    if id.nil? 
      @decks = initialize_decks(6)
      @id = (Card.last and Card.last.game_id + 1) || 0
      @player_cards = []
      @dealer_cards = []
    else
      @id = id
      cards = Card.where(game_id: id)
      @player_cards = cards.select{|card| card.user == USER[:player]}
      @dealer_cards = cards.select{|card| card.user == USER[:dealer]}
      @decks = initialize_decks(6, (@player_cards+@dealer_cards).map{|a| a.value})
      update_scores
    end
  end

  def deal_initial_cards
    2.times { @player_cards << Card.create(user: USER[:player], value: pop_card, game_id: self.id ) }
    @dealer_cards << Card.create(user: USER[:dealer], value: pop_card, game_id: self.id )
    update_scores
    who_won?
  end

  def deal_card(user)
    card = Card.create(user: user, value: pop_card, game_id: self.id)
    if user == USER[:player]
      @player_cards << card
    else
      @dealer_cards << card
    end
    update_scores
    who_won?
  end
  
  def stand
    return if winner.present?
    while (@dealer_score < 17) do
      deal_card(USER[:dealer])
    end
    @winner = (@player_score > @dealer_score) ? 'Player' : 'Dealer' if winner.blank?
  end

  private

  def update_scores
    @player_score = @player_cards.collect {|card| card.get_value }.sum
    @dealer_score = @dealer_cards.collect {|card| card.get_value }.sum
  end
  
  def who_won?
    if @player_score == 21 || @dealer_score > 21
      @winner = 'Player'
    elsif @player_score > 21 || @dealer_score == 21
      @winner = 'Dealer'
    end
  end

  def pop_card
    @decks.shuffle.delete_at(0)
  end

  def initialize_decks(num_of_decks, existing_cards=[])
    ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'K', 'Q', 'J'] * num_of_decks - existing_cards
  end
end