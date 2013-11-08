class Ability
    include CanCan::Ability

    def initialize(user)

        user ||= User.new # guest user (not logged in)

        if user.subscriber == true
            can :manage, Page, :user_id => user.id
            can :create, Stripe::Charge, :email => user.email


            user.pages.each do |access| 
                can [:create, :destroy], Collaborator, :user_id => user.id
                can [:create, :destroy], Viewer, :user_id => user.id
            end
        end

        if user.confirmed_at
            can [:create, :read, :update, :destroy], Page, :user_id => user.id
            can :create, Stripe::Charge, :email => user.email
            #collaborators may only update read a page when the page_ids match
            user.collaborators.each do |access|
                can [:update, :read], Page, :page_id => access.page_id
            end

            user.viewers.each do |access|
                can :read, Page, :page_id => access.page_id
            end
        end

    can  :read, Page, public: true # option for visitors

    end
end