class GamesController < ApplicationController

  def new
    @game = Game.new
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

  def game_params
    params.require(:game).permit(:new_players)
  end

end
