class FamilyGallery::PicturesController < FamilyGallery::ResourcesController

private

  def after_assign
    resource_instance.groups << FamilyGallery::Group.find(params[:group_id]) if params[:group_id].present?
  end

  def resource_params
    params.require(:picture).permit(:title, :description, :image)
  end
end
