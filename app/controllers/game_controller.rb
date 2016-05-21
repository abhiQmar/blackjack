class GameController < ApplicationController

  def index 
  end

  def start
    @game = Game.new
    @game.deal_initial_cards
    render 'game.html.haml'
  end

  def hit
    @game = Game.new(params[:game_id])
    @game.deal_card(Game::USER[:player])
    render 'game.html.haml'
  end

  def stand
    @game = Game.new(params[:game_id])
    @game.stand
    render 'game.html.haml'
  end
end
