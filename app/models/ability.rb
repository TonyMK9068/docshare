class Ability
    include CanCan::Ability

    def initialize(user)

        user ||= User.new # guest user (not logged in)

        if user.created_at 
            can [:create, :destroy], Charge, :user_id => user.id
            can :create, Page, :user_id => user.id

            user.user_page_instances('owner').each do |page|
                can :manage, Page, :id => page.id
                can :manage, Role, :page_id => page.id
            end

            user.user_page_instances('collaborator').each do |page|
                can [:read, :update], Page, :id => page.id
            end

            user.user_page_instances('viewer').each do |page|
                can :read, Page, :id => page.id
            end
        end

    can  :read, Page, public: true # public pages visible to all

    end
end