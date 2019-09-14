class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    @service = Services::Games::Create.new(game_params)
    @service.call
    Services::Games::PrepareGameplay.new(@service.game).prepare

    if @service.game.persisted?
      redirect_to controller: :steps, action: :current, game_id: @service.game.id
    end
  rescue LessThenTwoPlayers => e
     redirect_to action: :new, notice: e.message
  end

  private

  def game_params
    params.require(:game).permit(:new_players)
  end

end
