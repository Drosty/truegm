require 'spec_helper'

describe ApplicationHelper do

  describe "formatting number as money" do

    it "should return correct value from float" do
      format_as_money(123.4).should == "$123"
    end

    it "should return correct value from int" do
      format_as_money(1236).should == "$1,236"
    end

    it "should return correct value in millions" do
      format_as_money(236876564).should == "$236,876,564"
    end

  end

end
