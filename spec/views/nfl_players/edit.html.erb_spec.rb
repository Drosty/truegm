require 'spec_helper'

describe "nfl_players/edit" do
  before(:each) do
    @nfl_player = assign(:nfl_player, stub_model(NflPlayer))
  end

  it "renders the edit nfl_player form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", nfl_player_path(@nfl_player), "post" do
    end
  end
end
