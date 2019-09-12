class Player < ApplicationRecord

  belongs_to :game

  has_many :throws
  has_many :frames

end
