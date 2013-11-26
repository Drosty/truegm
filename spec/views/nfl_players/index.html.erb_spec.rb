require 'spec_helper'

describe "nfl_players/index" do
  before(:each) do
    assign(:nfl_players, [
      stub_model(NflPlayer),
      stub_model(NflPlayer)
    ])
  end

  it "renders a list of nfl_players" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
