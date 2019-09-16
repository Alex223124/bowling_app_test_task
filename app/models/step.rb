class Step < ApplicationRecord

  belongs_to :game
  has_one :throw


  def next
    Step.where("game_id = ? AND position > ?", game.id, position).first
  end

  def previous
    Step.where("game_id = ? AND position < ?", game.id, position).last
  end

  def frame
    throw.frame
  end

  def player
    frame.player
  end

  def mark_as_completed
    self.is_completed = true
    save!
  end

  def mark_as_skipped(reason)
    self.is_skipped = true
    self.reason_why_skipped = reason
    save!
  end

end