class FamilyGallery::GroupsController < FamilyGallery::ResourcesController
  def show
  end

private

  def resource_params
    params.require(:group).permit(:name, :description)
  end

  helper_method :groups_of_pictures
  def groups_of_pictures
    @group.pictures.find_in_batches(batch_size: 6) do |pictures|
      yield pictures
    end
  end
end
