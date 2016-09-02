require 'spec_helper'

describe "rosters/new" do
  before(:each) do
    assign(:roster, stub_model(Roster,
      :name => "MyString",
      :qb1 => 1,
      :rb1 => 1,
      :rb2 => 1,
      :wr1 => 1,
      :wr2 => 1,
      :te => 1,
      :flex => 1,
      :utility => 1,
      :pk => 1
    ).as_new_record)
  end

  it "renders new roster form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", rosters_path, "post" do
      assert_select "input#roster_name[name=?]", "roster[name]"
      assert_select "input#roster_qb1[name=?]", "roster[qb1]"
      assert_select "input#roster_rb1[name=?]", "roster[rb1]"
      assert_select "input#roster_rb2[name=?]", "roster[rb2]"
      assert_select "input#roster_wr1[name=?]", "roster[wr1]"
      assert_select "input#roster_wr2[name=?]", "roster[wr2]"
      assert_select "input#roster_te[name=?]", "roster[te]"
      assert_select "input#roster_flex[name=?]", "roster[flex]"
      assert_select "input#roster_utility[name=?]", "roster[utility]"
      assert_select "input#roster_pk[name=?]", "roster[pk]"
    end
  end
end
