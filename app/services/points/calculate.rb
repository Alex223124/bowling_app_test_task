class Services::Points::Calculate

  POINTS_FOR_STRIKE = 10
  POINTS_FOR_SPARE = 10

  def initialize(step)
    @step = step
    @throw = step.throw
    @point = @throw.frame.point
    @game = step.game
  end

  def call
    ActiveRecord::Base.transaction do
      if @throw.is_strike?
        @point.update_status("on_hold", "strike_case")
      elsif @throw.is_spare?
        @point.update_status("on_hold", "spare_case")
      elsif @throw.frame.is_bonus_frame?
        @point.update_status("calculated")
      elsif @throw.is_first_throw_in_frame?
        @point.update_status("on_hold", "waiting_for_result_of_second_throw")
      elsif @throw.is_second_throw_in_frame?

        if can_calculate_regular_case?(@point)
          raise WrongValueForSecondThrow if !@throw.valid_sum_of_throws?
          @point.update_status("calculated")
          result = calculate_regular_case(@point)
          @point.update_value(result)
        else
          @point.update_status("on_hold", "waiting_for_result_of_previous_frame")
        end
      end
    end
     calculate_previous_throws
  end

  private

  # TODO! should be background job for calculations + cache for view
  def calculate_previous_throws
    Point.pending(@game.id).each do |point|
      if point.status_reason == "strike_case"
        return if !can_calculate_strike?(point)
        point.update_status("calculated")
        result = calculate_stike_case(point)
        point.update_value(result)
        calculate_previous_throws

      elsif point.status_reason == "spare_case"
        return if !can_calculate_spare?(point)
        point.update_status("calculated")
        result = calculate_spare_case(point)
        point.update_value(result)
        calculate_previous_throws
      else
        # regular case
        return if can_calculate_regular_case?
        point.update_status("calculated")
        result = calculate_regular_case(point)
        point.update_value(result)
        calculate_previous_throws
      end
    end
  end

  def can_calculate_strike?(point)
    point.frame.throws.first.next_throws_completed?(2) &&
    previous_frame_calculated?(point.frame)
  end

  def can_calculate_spare?(point)
    point.frame.throws.second.next_throws_completed?(1) &&
    previous_frame_calculated?(point.frame)
  end

  def can_calculate_regular_case?(point)
    previous_frame_calculated?(point.frame) &&
    point.frame.both_throws_completed?
  end


  def previous_frame_calculated?(frame)
    if frame.number == Frame::FIRST_FRAME_NUMBER_FOR_PLAYER
      true
    else
      frame.previous.point.value != nil
    end
  end

  def calculate_stike_case(point)
    point.previous_frame_result +
    POINTS_FOR_STRIKE +
    point.points_for_throw_from_next_frame("first") +
    point.points_for_next_second_throw
  end

  def calculate_spare_case(point)
    point.previous_frame_result +
    POINTS_FOR_SPARE +
    point.points_for_throw_from_next_frame("first")
  end

  def calculate_regular_case(point)
    point.previous_frame_result +
    point.frame.sum_of_two_throws * Frame::POINTS_FOR_ONE_KNOCKED_DOWN_PIN
  end

end
