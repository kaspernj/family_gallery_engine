class FamilyGallery::UsersController < FamilyGallery::ResourcesController
  def show
  end

private

  def resource_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
