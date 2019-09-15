class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    @service = Services::Games::PrepareBase.new(@service.game).call
    @service.call

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
