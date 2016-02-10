class FamilyGallery::UserRolesController < FamilyGallery::ResourcesController
  load_resource :user, class: "FamilyGallery::User"
  load_and_authorize_resource :user_role, class: "FamilyGallery::UserRole", through: :user

  def new
  end

  def create
    @user_role.user = @user

    if @user_role.save
      redirect_to @user_role.user
    else
      flash[:error] = @user_role.errors.full_messages.join(". ")
      render :new
    end
  end

  def destroy
    unless @user_role.destroy
      flash[:errror] = @user_role.errors.full_messages.join(". ")
    end

    redirect_to @user_role.user
  end

private

  def user_role_params
    params.require(:user_role).permit(:role)
  end
end
