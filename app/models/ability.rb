class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.created_at
      can [:create, :destroy], Charge, user_id: user.id
      can :create, Page, user_id: user.id

      Page.all.each do |page|
        if user.pages_viewable.include? page
          can :read, page
        end
      
        if user.pages_collaborating_on.include? page
          can [:read, :update], page
        end
        
        if user.pages_owned.include? page
          can :manage, page
          can :manage, Role, page_id: page.id
        end
      end
    end

    can  :read, Page, public: true
  end
end