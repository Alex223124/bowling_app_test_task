class Frame < ApplicationRecord

  BONUS_FRAME_NUMBER = 11
  self.inheritance_column = nil

  belongs_to :player
  has_many :throws

  def is_last_basic_frame?
    self.number == 10
  end

end
