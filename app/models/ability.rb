class Ability
    include CanCan::Ability

    def initialize(user)

        user ||= User.new # guest user (not logged in)

        if user.created_at 
            can [:create, :destroy], Charge, :user_id => user.id
            can :manage, Page

            user.pages_owned.each do |page|
                can :manage, Page, :id => page.id
                can :manage, Role, :page_id => page.id
            end

            user.pages_can_collaborate.each do |page|
                can [:read, :update], Page, :id => page.id
            end

            user.pages_can_view.each do |page|
                can :read, Page, :id => page.id
            end
        end

    can  :read, Page, public: true # public pages visible to all

    end
end