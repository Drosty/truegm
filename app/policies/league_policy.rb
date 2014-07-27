class LeaguePolicy < Struct.new(:user, :league)

  class Scope < Struct.new(:user, :scope)
    # Admins can access all posts on the index view,
    # any other user will only be able to see published ones
    def resolve
      if user.is_admin?
        League.all
      else
        user.leagues
      end
    end
  end

  def index?
    !user.nil?
  end

  def show?
    if user.nil?
      return false
    else
      return user.is_admin || user.leagues.include?(league)
    end
  end

end
