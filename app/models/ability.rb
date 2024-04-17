class Ability
    include CanCan::Ability
  
    def initialize(user)
      user ||= User.new # Guest user
  
      if user.has_role?(:admin)
        can :manage, User, except: [:username, :email, :password]
        can :manage, :all # Admin can perform any action on any model [^^except the above I think(not sure )]
      elsif user.has_role?(:moderator)
        can :read, Post
        can :create, Post
        can :update, Post, user_id: user.id
        can :manage, Category
        can :manage, Location
        can :destroy, Post
      elsif user.has_role?(:writer)
        can :read, Post
        can :create, Post
      elsif user.has_role?(:viewer)
        can :read, Post
      else
        can :read, Post    

        # Define other permissions for regular users
      end
    end
  end