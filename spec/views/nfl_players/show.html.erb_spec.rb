require 'spec_helper'

describe "nfl_players/show" do
  before(:each) do
    @nfl_player = assign(:nfl_player, stub_model(NflPlayer))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
