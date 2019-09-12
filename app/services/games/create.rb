class Services::Games::Create

  attr_reader :game

  def initialize(params)
    @new_players = params[:new_players]
    @game = Game.new
  end

  def call
    raise LessThenTwoPlayers.new if players_names.count < 2
    generate_players
    set_title
    @game.save!
  end

  private

  def players_names
    @new_players.split(",")
  end

  def generate_players
    players_names.each do |name|
      @game.players.new(name: name)
    end
  end

  def set_title
    @game.title = "Game between: #{@new_players}"
  end

end