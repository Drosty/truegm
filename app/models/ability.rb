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
        can :read, League, :teams => { :user_id => user.id }

        # Team Rules
        can :update, Team, :user_id => user.id
        can :read, Team do |team|
          if team == nil or team.league == nil
            false 
          else
            user.leagues.select{|l| l.id == team.league.id}.count > 0
          end
        end

        # Forum Topic Rules
        can :read, ForumTopic do |topic|
          if topic == nil or topic.league == nil
            false
          else
            user.leagues.select{|l| l.id == topic.league_id}.count > 0
          end
        end

        can :create, ForumTopic
        can :update, ForumTopic  # BIG TODO HERE - ONLY UPDATE ONES YOU CREATE!

        # Forum Post Rules
        can :read, ForumPost
        can :create, ForumPost do |post|
          if post == nil or post.league == nil
            false
          else
            user.leagues.select{|l| l.id == post.league.id}.count > 0
          end
        end
        can :update, ForumPost, :user => user
      end
    end
  end
end