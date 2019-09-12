class Frame < ApplicationRecord

  self.inheritance_column = nil

  belongs_to :player
  has_many :throws

end
