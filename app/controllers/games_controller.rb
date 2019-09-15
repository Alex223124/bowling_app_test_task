class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    @service = Services::Games::Create.new(game_params)
    @service.call
    Services::Games::PrepareBase.new(@service.game).prepare

    if @service.game.persisted?
      redirect_to controller: :steps, action: :current, game_id: @service.game.id
    end

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
