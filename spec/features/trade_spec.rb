require 'spec_helper'

describe 'trade' do
  describe 'proposing trade' do
    it 'can only happen between teams in same league' do
    
    end
    
    it 'trade shows up in the proposed trades page' do
    
    end
    
    it 'creates trade vote objects for every team in the league' do
      # just make sure vote count goes up by 8 and only 8
    end
  end

  describe 'trading' do
    it 'can trade between players is same league' do
    
    end
    
    it 'can happen when votes allow it too' do
    
    end
    
    describe 'trade players only' do
      it 'players go to correct teams' do
    
      end
    
      it 'teams salary cap updates' do
    
      end
    end
    
    describe 'trade draft picks only' do
      it 'draft picks go to correct teams' do
      
      end
    end
    
    describe 'trade money only' do
      it 'teams salary cap updates accordingly' do
      
      end
    end
    
    describe 'trade players and picks' do
      it 'players and picks update accordingly' do
      
      end
    end
    
    describe 'trade players and money' do
      it 'players and salary cap update accordingly' do
      
      end
    end
    
    describe 'trade picks and money' do
      it 'picks and salary cap update accordingly' do
      
      end
    end
    
    describe 'trade players, picks and money' do
      it 'updates everything accordingly' do
      
      end
    end
  end
end