require 'rails_helper'

RSpec.describe "games/edit", type: :view do
  before(:each) do
    @game = assign(:games, Game.create!())
  end

  it "renders the edit games form" do
    render

    assert_select "form[action=?][method=?]", game_path(@game), "post" do
    end
  end
end
