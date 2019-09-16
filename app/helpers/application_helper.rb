module ApplicationHelper

  def point_value(frame)
    value = frame.point.value
    if frame.throws.where(number_of_knocked_down_pins: nil).count == 2
      "Waiting for both throws to be completed"
    elsif value
      value
    elsif value == nil
      "Status: #{frame.point.status} | Status reason: #{frame.point.status_reason}"
    end
  end

  def throw_result(throw)
    if throw.number_of_knocked_down_pins == nil && !throw.step.is_skipped
      "Throw is pending"
    elsif throw.step.is_skipped
      "Skipped, reason why skipped: #{throw.step.reason_why_skipped}"
    else
      throw.number_of_knocked_down_pins
    end
  end

end
