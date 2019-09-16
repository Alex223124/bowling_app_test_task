class Services::Games::Gameplay::PrepareBonus < Services::Games::Gameplay::PrepareBase

  TYPE_OF_BONUS_FRAME = "bonus_frame".freeze

  def initialize(frame)
    @previous_frame = frame
    @game = frame.player.game
    @steps_counter = first_bonus_step_position
    @frames_counter = Frame::BONUS_FRAME_NUMBER
  end

  def call
    ActiveRecord::Base.transaction do
      frame = build_frame(@previous_frame.player, TYPE_OF_BONUS_FRAME)
      build_throws(frame)
      build_steps(frame.throws)
      build_point(frame)
    end
  end

  private

  def first_bonus_step_position
    @previous_frame.throws.last.step.position + 1
  end

end