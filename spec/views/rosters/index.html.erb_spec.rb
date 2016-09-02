require 'spec_helper'

describe "rosters/index" do
  before(:each) do
    assign(:rosters, [
      stub_model(Roster,
        :name => "Name",
        :qb1 => 1,
        :rb1 => 2,
        :rb2 => 3,
        :wr1 => 4,
        :wr2 => 5,
        :te => 6,
        :flex => 7,
        :utility => 8,
        :pk => 9
      ),
      stub_model(Roster,
        :name => "Name",
        :qb1 => 1,
        :rb1 => 2,
        :rb2 => 3,
        :wr1 => 4,
        :wr2 => 5,
        :te => 6,
        :flex => 7,
        :utility => 8,
        :pk => 9
      )
    ])
  end

  it "renders a list of rosters" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
  end
end
