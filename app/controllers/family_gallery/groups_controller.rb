class FamilyGallery::GroupsController < FamilyGallery::ResourcesController

private

  def resource_params
    params.require(:group).permit(:name, :description)
  end
end
