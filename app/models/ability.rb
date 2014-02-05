class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.is_admin?
        can :read, :all
        can :update, :all
        can :create, :all
        can :destroy, :all
      else
        # League Rule
        can :read, League do |league|
          league.teams.select{|team| team.user_id == user.id }.count > 0
        end

        # Team Rules
        can :update, Team, :user_id => user.id
        can :read, Team do |team|
          if team == nil or team.league == nil
            false
          else
            user.leagues.select{|l| l.id == team.league.id}.count > 0
          end
        end

        # rules on trade votes
        can :create, TradeVote do |vote|
          if vote == nil or vote.trade == nil  or vote.trade.to_team == nil or vote.trade.from_team == nil or vote.trade.to_team.league == nil or vote.trade.from_team.league == nil
            false
          else
            user.leagues.select{|l| l.id == vote.trade.to_team.league.id}.count > 0
          end
        end

      end
    end
  end
end
