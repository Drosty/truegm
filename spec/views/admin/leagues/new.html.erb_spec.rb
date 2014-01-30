require 'spec_helper'

describe "admin/leagues/new" do
  before(:each) do
    assign(:admin_league, stub_model(Admin::League).as_new_record)
  end

  it "renders new admin_league form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", admin_leagues_path, "post" do
    end
  end
end
