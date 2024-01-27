class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role == 'admin'
      can :manage, :all
    elsif user.role == 'user'
      can :manage, Expense, author_id: user.id
      can :manage, Group, user_id: user.id
      can :manage, User, id: user.id
    else
      cannot :manage, :all
    end
  end
end
