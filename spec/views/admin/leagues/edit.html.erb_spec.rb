require 'spec_helper'

describe "admin/leagues/edit" do
  before(:each) do
    @admin_league = assign(:admin_league, stub_model(Admin::League))
  end

  it "renders the edit admin_league form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_league_path(@admin_league), "post" do
    end
  end
end
