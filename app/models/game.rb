class Game < ApplicationRecord

  has_many :players
  has_many :steps, -> { order(position: :asc) }

  def current_step
    steps.where(is_completed: false, is_skipped: false).first
  end

  def last_step
    steps.last
  end

end
