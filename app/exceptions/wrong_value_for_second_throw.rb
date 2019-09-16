class WrongValueForSecondThrow < StandardError

  attr_reader :message

  def initialize(message="Max value of 2 throws in the same frame should be 10. Enter corrent value.")
    @message = message
  end

end