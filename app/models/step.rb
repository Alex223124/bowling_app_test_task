class Step < ApplicationRecord

  has_one :throw


  def frame
    throw.frame
  end

  def player
    frame.player
  end

end
