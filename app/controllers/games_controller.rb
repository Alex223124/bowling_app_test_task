class GamesController < ApplicationController

  before_action :set_game, only: [:show]
  
  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def show
  end

  def create
    @create = Services::Games::Create.new(game_params)
    @create.call
    Services::Games::Gameplay::PrepareBase.new(@create.game).call

    redirect_to controller: :steps, action: :current, game_id: @create.game.id
  rescue LessThenTwoPlayers => e
    flash[:error] = e.message
    redirect_to action: :new, notice: e.message
  rescue => e
    flash[:error] = e.message
    redirect_to action: :new
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:new_players)
  end

end
