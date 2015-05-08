class FamilyGallery::Ability
  include CanCan::Ability

  def initialize(user)
    @user = user

    if @user
      user_access

      @user.user_roles.each do |user_role|
        __send__(user_role.role)
      end
    end
  end

private

  def user_access
    can [:index, :new, :create], FamilyGallery::Group
    can [:show, :edit, :update, :destroy], FamilyGallery::Group, user_owner_id: @user.id

    can [:new, :create], FamilyGallery::Picture
    can [:edit, :update, :destroy], FamilyGallery::Picture, user_owner_id: @user.id

    can [:new, :create, :edit, :update, :destroy], FamilyGallery::UserTagging do |tagging|
      tagging.picture.user_owner == @user
    end
  end

  def administrator
    can :manage, FamilyGallery::Group
    can :manage, FamilyGallery::Picture
    can :manage, FamilyGallery::User
    can :manage, FamilyGallery::UserTagging
  end
end
