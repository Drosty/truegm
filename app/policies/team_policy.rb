class TeamPolicy < Struct.new(:user, :team)

  class Scope < Struct.new(:user, :scope)
    # Admins can access all posts on the index view,
    # any other user will only be able to see published ones
    def resolve
      scope
    end
  end

  def update?
    
  end

end
