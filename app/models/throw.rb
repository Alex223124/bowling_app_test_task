class Throw < ApplicationRecord

  AMOUNT_OF_KNOCKED_DOWN_PINS_FOR_STRIKE = 10
  SUM_OF_TWO_THROWS_FOR_SPARE = 10
  MAX_KNOCKED_DOWN_PINS_BY_TWO_THROWES = 10

  belongs_to :frame
  belongs_to :step, optional: true

  scope :completed_by_same_player, -> (throw) { where(frame_id: throw.frame.player.frames).
                                                  where.not(number_of_knocked_down_pins: nil) }



  def next_throws_completed?(amount)
    Throw.completed_by_same_player(self).where("step_id > ?", self.step_id).count >= amount
  end

  def valid_sum_of_throws?
    self.number_of_knocked_down_pins +
    self.frame.throws.first.try(:number_of_knocked_down_pins) <= MAX_KNOCKED_DOWN_PINS_BY_TWO_THROWES
  end

  def mark_throw_result(number_of_knocked_down_pins)
    self.number_of_knocked_down_pins = number_of_knocked_down_pins
    self.save!
  end

  def mark_as_strike
    self.is_strike = true
    self.save!
  end

  def mark_as_spare
    self.is_spare = true
    self.save!
  end

  def is_spare?
    is_second_throw_in_frame? && is_sum_for_spare_achieved?
  end

  def is_strike?
    (number_of_knocked_down_pins == AMOUNT_OF_KNOCKED_DOWN_PINS_FOR_STRIKE) &&
    is_first_throw_in_frame? &&
    frame.number != Frame::BONUS_FRAME_NUMBER
  end

  def is_first_throw_in_frame?
    frame == step.try(:next).try(:frame)
  end

  def is_second_throw_in_frame?
    step.try(:previous).try(:frame) == step.try(:frame)
  end

  def is_sum_for_spare_achieved?
    sum_with_previous_throw == SUM_OF_TWO_THROWS_FOR_SPARE
  end

  def sum_with_previous_throw
    number_of_knocked_down_pins + step.frame.throws.first.number_of_knocked_down_pins
  end

end
