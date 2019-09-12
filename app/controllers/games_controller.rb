class GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def create
    @service = Services::Games::CreateGame.new(game_params)
    @service.call

    respond_to do |format|
      if @service.game.persisted?
        redirect_to @games, notice: 'Game was successfully created.'
      else
        # render :new
      end
    end
  rescue LessThenTwoPlayers => e
     redirect_to action: :new, notice: e.message
  end

  private

    def game_params
      params.require(:game).permit(:new_players)
    end

end
