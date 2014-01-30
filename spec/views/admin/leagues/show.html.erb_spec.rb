require 'spec_helper'

describe "admin/leagues/show" do
  before(:each) do
    @admin_league = assign(:admin_league, stub_model(Admin::League))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
