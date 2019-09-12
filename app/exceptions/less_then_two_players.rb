# A plain old ruby class inheriting from StandardError
class LessThenTwoPlayers < StandardError

  attr_reader :message

  def initialize(message="Should be at least 2 players!")
    @message = message
  end

end