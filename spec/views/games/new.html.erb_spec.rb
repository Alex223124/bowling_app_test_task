require 'rails_helper'

RSpec.describe "games/new", type: :view do
  before(:each) do
    assign(:games, Game.new())
  end

  it "renders new games form" do
    render

    assert_select "form[action=?][method=?]", games_path, "post" do
    end
  end
end
