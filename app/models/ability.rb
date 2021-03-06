# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    
    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can [:create, :comment], [Question, Answer]
    can :update, [Question, Answer], { user_id: user.id }
    can :destroy, [Question, Answer], { user_id: user.id }

    can :mark_as_best, Answer, question: { user_id: user.id }
    can :destroy, Link, linkable: { user_id: user.id }
    can :destroy, ActiveStorage::Attachment, record: { user_id: user.id }

    can %i[vote_up vote_down unvote], [Question, Answer] do |vote|
      !user.author?(vote)
    end

    can :create, Subscription
    can :destroy, Subscription, user_id: @user.id
  end
end
