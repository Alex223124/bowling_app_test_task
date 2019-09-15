class StepsController < ApplicationController

  before_action :set_game, only: [:current]
  before_action :set_step, only: [:update]

  def current
    @step = @game.current_step
  end


  def update
    @update = Services::Steps::Update.new(@step, step_params)
    @update.call

    if @step.frame.is_last_basic_frame?
      @prepare_serivce = Services::Games::Gameplay::PrepareBonus.new(@step.frame)
      @prepare_serivce.call
    end

    flash[:success] = "Success!"
    redirect_to action: :current, game_id: @step.game.id
  rescue => e
    flash[:error] = "Something went wrong. Please, write your result again. Error: #{e}"
    redirect_to action: :current, game_id: @step.game.id
  end

  private

  def set_step
    @step = Step.find(params[:id])
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  def step_params
    params.require(:step).permit(:number_of_knocked_down_pins)
  end

end
