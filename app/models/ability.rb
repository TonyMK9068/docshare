class Ability
    include CanCan::Ability

    def initialize(user)

        user ||= User.new # guest user (not logged in)

        if user.subscriber == true
            can :manage, Page, :user_id => user.id
            can :create, Stripe::Charge, :email => user.email
        end

        if user.confirmed_at
            can [:create, :read, :update, :destroy], Page, :user_id => user.id
            can :create, Stripe::Charge, :email => user.email
            #collaborators may only update read a page when the page_ids match

            user.can_collaborate.each do |access|
                can [:update, :read], Page, :user_id => access.collaborator_id
            end

            user.can_view.each do |access|
                can :read, Page, :user_id => access.viewer_id
            end
        end

    can  :read, Page, public: true # option for visitors

    end
end