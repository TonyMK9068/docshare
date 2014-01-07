class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.created_at
      can [:create, :destroy], Charge, user_id: user.id
      can :create, Page, user_id: user.id
      
      user.projects.each do |project|
        if user.private_projects_shared.include? project
          can :read, project
        end

        if user.collaborations.include? project
          can [:read, :update], project
        end
      end
      
      user.pages.each do |page|
        can :manage, page
        can :manage, Role, page_id: page.id
      end
    end

    can  :read, Page, public: true
  end
end