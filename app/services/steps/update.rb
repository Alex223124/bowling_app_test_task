class Services::Steps::Update

  def initialize(step, step_params)
    @step = step
    @throw = step.throw
    @params = step_params
  end

  def call
    ActiveRecord::Base.transaction do
      mark_throw
      add_bonus_throws
      calculate_throw_result
    end
  end

  private

  def mark_throw
    @throw.mark_throw_result(@params[:number_of_knocked_down_pins])

    if @throw.is_strike?
      @throw.mark_as_strike
      @step.frame.throws.where.not(id: @throw.id).first.step.try(:mark_as_skipped, "strike_by_first_throw")
    elsif @throw.is_spare?
      @throw.mark_as_spare
    else
      # regular case
    end
    @step.mark_as_completed
  end

  def add_bonus_throws
    if @step.frame.is_last_basic_frame?
      Services::Games::Gameplay::PrepareBonus.new(@step.frame).call
    end
  end

  def calculate_throw_result
    Services::Points::Calculate.new(@step).call
  end

end