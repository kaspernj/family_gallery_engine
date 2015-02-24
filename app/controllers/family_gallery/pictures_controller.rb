class FamilyGallery::PicturesController < FamilyGallery::ResourcesController

private

  def resource_params
    params.require(:picture).permit(:title, :description, :image)
  end
end
