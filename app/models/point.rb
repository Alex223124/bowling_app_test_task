class Point < ApplicationRecord

  POINTS_FOR_ONE_KNOCKED_DOWN_PIN = 1

  belongs_to :frame

  scope :pending, -> (game_id) { where(frame_id: Frame.where(player_id: Player.where(game_id:game_id)), status: "on_hold") }

  def first_frame_throw
    frame.throws.first
  end

  def previous_frame_result
    if frame.first_in_game?
      0
    else
      frame.previous.point.value
    end
  end

  def points_for_throw_from_next_frame(frame_index = 1, position)
    next_frame = self.frame
    frame_index.times { next_frame = next_frame.next}
    next_frame.throws.public_send(position).number_of_knocked_down_pins * POINTS_FOR_ONE_KNOCKED_DOWN_PIN
  end

  def points_for_next_second_throw
    if frame.next.throws.first.is_strike?
      points_for_throw_from_next_frame(2, "first" )
    else
      points_for_throw_from_next_frame("second")
    end
  end

  def update_value(value)
    self.value = value
    self.save!
  end

  def update_status(status, status_reason = nil)
    self.status = status
    self.status_reason = status_reason
    self.save!
  end
end
