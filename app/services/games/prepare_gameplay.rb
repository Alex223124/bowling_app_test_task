class Services::Games::PrepareGameplay

  BASIC_AMOUNT_OF_FRAMES_FOR_SINGLE_PLAYER = 10
  BASIC_AMOUT_OF_THROWS_FOR_SINGLE_FRAME = 2

  def initialize(game)
    @game = game
    @steps_counter = 0
  end

  def prepare
    build_gameplay
  end

  private

  def build_gameplay
    BASIC_AMOUNT_OF_FRAMES_FOR_SINGLE_PLAYER.times do
      @game.players.each do |player|
        frame = build_frame(player)
        build_throws(frame)
        build_steps(frame.throws)
      end
    end
  end

  def build_frame(player)
    player.frames.create!(type: "basic_ten_frames")
  end

  def build_throws(frame)
    BASIC_AMOUT_OF_THROWS_FOR_SINGLE_FRAME.times do
      frame.throws.create!
    end
  end

  def build_steps(throws)
    throws.each do |throw|
      throw.create_step!(game:@game, position: @steps_counter+=1)
    end
  end

end