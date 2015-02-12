require 'spec_helper'

describe LeagueHelper do

  it "will return correct class when over salary cap" do
    t = build(:team)
    t.league.salary_cap = 1000
    t.total_salary = 2000
    salary_display_color_class(t).should == "text-error"
  end

  it "will return correct class when under salary cap" do
    t = build(:team)
    t.league.salary_cap = 5000
    t.total_salary = 2000
    salary_display_color_class(t).should == "text-success"
  end

end
