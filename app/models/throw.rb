class Throw < ApplicationRecord

  AMOUNT_OF_KNOCKED_DOWN_PINS_FOR_STRIKE = 10
  SUM_OF_TWO_THROWS_FOR_SPARE = 1..9

  belongs_to :frame
  belongs_to :step, optional: true

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
    (number_of_knocked_down_pins == AMOUNT_OF_KNOCKED_DOWN_PINS_FOR_STRIKE) && is_first_throw_in_frame?
  end

  def is_first_throw_in_frame?
    frame == step.next.frame
  end

  def is_second_throw_in_frame?
    step.try(:pervious).try(:frame) == step.frame
  end

  def is_sum_for_spare_achieved?
    sum_with_pervious_throw == SUM_OF_TWO_THROWS_FOR_SPARE
  end

  def sum_with_pervious_throw
    number_of_knocked_down_pins + step.pervious.throw.number_of_knocked_down_pins
  end

end
