require 'rails_helper'

RSpec.describe "games/show", type: :view do
  before(:each) do
    @game = assign(:games, Game.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
