class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.created_at 
      can [:create, :destroy], Charge, :user_id => user.id
      can :create, Page, :user_id => user.id

      if user.pages_with_role('owner').present?
        can :manage, Page, id: user.pages_with_role('owner').each { |page| page.id }
        can :manage, Role, page_id: user.pages_with_role('owner').each { |page| page.id }
      end

      if user.pages_with_role('collaborator').present?
        can [:read, :update], Page, id: user.pages_with_role('collaborator').each { |page| page.id }
      end

      if user.pages_with_role('viewer').present?
        can :read, Page, id: user.pages_with_role('collaborator').each { |page| page.id } 
      end
      
    end
    can  :read, Page, public: true # public pages visible to all
  end
end