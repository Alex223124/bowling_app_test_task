class StepsController < ApplicationController

  before_action :set_game, only: [:current]
  before_action :set_step, only: [:update]

  def current
    @step = @game.current_step
  end


  def update
    Services::Steps::Update.new(@step, step_params).call

    respond_to do |format|
      if @game.update(step_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
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
