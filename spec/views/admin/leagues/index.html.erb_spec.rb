require 'spec_helper'

describe "admin/leagues/index" do
  before(:each) do
    assign(:admin_leagues, [
      stub_model(Admin::League),
      stub_model(Admin::League)
    ])
  end

  it "renders a list of admin/leagues" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
