class TeamPolicy < Struct.new(:user, :team)

  class Scope < Struct.new(:user, :scope)
    # Admins can access all posts on the index view,
    # any other user will only be able to see published ones
    def resolve
      scope
    end
  end

  def update?
    if user.is_admin?
      true
    else
      is_team_owned_by_user?
    end
  end

  def edit?
    if user.is_admin?
      true
    else
      is_team_owned_by_user?
    end
  end

  def show?
    if user.is_admin?
      true
    else
      is_team_owned_by_user? || is_team_in_league_that_user_is_in?
    end
  end

  private

  def is_team_owned_by_user?
    team.user == user
  end

  def is_team_in_league_that_user_is_in?
    user.leagues.to_a.map(&:id).include?(team.league_id)
  end

end
