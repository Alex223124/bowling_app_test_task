class Game < ApplicationRecord

  has_many :players

  before_create :set_title

  private

  def set_title
  end

end
