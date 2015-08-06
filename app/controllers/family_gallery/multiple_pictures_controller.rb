class FamilyGallery::MultiplePicturesController < FamilyGallery::BaseController
  before_filter :set_group_and_auth

  def new
  end

  def create
    picture_params[:files].each do |file|
      picture = FamilyGallery::Picture.new(
        image: file,
        user_owner: current_user,
        user_uploaded: current_user
      )
      picture.groups << @group
      picture.save!
    end

    redirect_to @group
  end

private

  def set_group_and_auth
    @group = FamilyGallery::Group.find(params[:group_id])
    authorize! :create, FamilyGallery::Picture.new(groups: [@group])
  end

  def picture_params
    params.require(:multiple_pictures).permit(files: [])
  end
end
