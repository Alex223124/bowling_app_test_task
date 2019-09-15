class Services::Steps::Update

  def initialize(step, step_params)
    binding.pry
    @step = step
    @throw = step.throw
    @params = step_params
  end

  def call
    binding.pry
    ActiveRecord::Base.transaction do
      @throw.mark_throw_result(@params[:number_of_knocked_down_pins])

      if @throw.is_strike?
        @throw.mark_as_strike
        @step.try(:next).try(:mark_as_skipped, "strike_by_first_throw")
      elsif @throw.is_spare?
        @throw.mark_as_spare
      else
        # regular case
      end
      @step.mark_as_completed
    end
  end

end