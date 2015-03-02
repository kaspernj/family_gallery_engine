class FamilyGallery::Ability
  include CanCan::Ability

  def initialize(user)
    @user = user

    if @user
      @user.user_roles.each do |user_role|
        __send__(user_role.role)
      end
    end
  end

private

  def administrator
    can :manage, FamilyGallery::Group
    can :manage, FamilyGallery::Picture
    can :manage, FamilyGallery::User
    can :manage, FamilyGallery::UserTagging
  end
end
