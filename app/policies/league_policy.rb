class LeaguePolicy
  attr_reader :user, :league

  def initialize(user, league)
    @user = user
    @league = league
  end

  def index?
    !@user.nil?
  end

  def show?
    if @user.nil?
      return false
    else
      return @user.is_admin || @user.leagues.include?(@league)
    end
  end

end
