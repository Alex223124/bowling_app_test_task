class Services::Games::Gameplay::PrepareBase

  BASIC_AMOUNT_OF_FRAMES_FOR_SINGLE_PLAYER = 10
  BASIC_AMOUT_OF_THROWS_FOR_SINGLE_FRAME = 2
  TYPE_OF_BASIC_FRAME = "basic_ten_frames".freeze
  FIRST_STEP_POSITION = 1
  FIRST_FRAME_NUMBER = 1

  def initialize(game)
    @game = game
    @steps_counter = FIRST_STEP_POSITION
    @frames_counter = FIRST_FRAME_NUMBER
  end

  def call
    build_gameplay
  end

  private

  def build_gameplay
    ActiveRecord::Base.transaction do
      BASIC_AMOUNT_OF_FRAMES_FOR_SINGLE_PLAYER.times do
        @game.players.each do |player|
          frame = build_frame(player, TYPE_OF_BASIC_FRAME)
          build_throws(frame)
          build_steps(frame.throws)
          frame.throws.each { |throw| build_points(throw.step) }
        end
        increment_frame_counter
      end
      clear_frame_counter
    end
  end

  def increment_frame_counter
    @frames_counter += 1
  end

  def increment_step_counter
    @steps_counter += 1
  end

  def clear_frame_counter
    @frames_counter = 0
  end

  def build_points(step)
    step.create_point!
  end

  protected

  def build_frame(player, type)
    player.frames.create!(type: type, number: @frames_counter)
  end

  def build_throws(frame)
    BASIC_AMOUT_OF_THROWS_FOR_SINGLE_FRAME.times do
      frame.throws.create!
    end
  end

  def build_steps(throws)
    throws.each do |throw|
      throw.create_step!(game: @game, position: @steps_counter)
      increment_step_counter
    end
  end

end