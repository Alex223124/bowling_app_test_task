class Frame < ApplicationRecord

  FIRST_FRAME_NUMBER_FOR_PLAYER = 1
  BONUS_FRAME_NUMBER = 11
  self.inheritance_column = nil

  belongs_to :player
  has_many :throws
  has_one :point

  def is_last_basic_frame?
    self.number == 10
  end

  def is_bonus_frame?
    self.number == BONUS_FRAME_NUMBER
  end

  def first_in_game?
    self.previous == nil
  end

  def both_throws_completed?
    throws.where.not(number_of_knocked_down_pins: nil).count == 2
  end

  def sum_of_two_throws
    throws.first.number_of_knocked_down_pins +
    throws.second.number_of_knocked_down_pins
  end

  def next
    Frame.where("player_id = ? AND number > ?", player.id, number).first
  end

  def previous
    Frame.where("player_id = ? AND number < ?", player.id, number).last
  end

end
