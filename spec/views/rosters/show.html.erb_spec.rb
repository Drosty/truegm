require 'spec_helper'

describe "rosters/show" do
  before(:each) do
    @roster = assign(:roster, stub_model(Roster,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
    rendered.should match(/7/)
    rendered.should match(/8/)
    rendered.should match(/9/)
  end
end
