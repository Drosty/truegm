require 'spec_helper'

describe "nfl_players/new" do
  before(:each) do
    assign(:nfl_player, stub_model(NflPlayer).as_new_record)
  end

  it "renders new nfl_player form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", nfl_players_path, "post" do
    end
  end
end
