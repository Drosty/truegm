require 'spec_helper'

describe Trade do
  before(:each) do
    @trade = build(:trade)
  end

  it "Factory Generates Valid Model" do
    @trade.should be_valid
  end
  
  describe 'validity' do
    it 'teams involved are in same league' do
    
    end
    
    it 'cannot have teams in different leagues' do
    
    end
    
    it 'draft picks are in same league' do
    
    end
    
    it 'draft picks cannot be in different league' do
    
    end
    
    it 'money has to be associated to teams in same league' do
    
    end
    
    it 'has the same amount of votes as players in the league' do
    
    end
  end
end
