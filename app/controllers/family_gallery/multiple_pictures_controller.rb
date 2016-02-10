class FamilyGallery::MultiplePicturesController < FamilyGallery::BaseController
  before_filter :set_group_and_auth

  def new
  end

  def create
    errors = []
    exceptions = []

    picture_params[:files].each do |file|
      picture = FamilyGallery::Picture.new(
        image: file,
        user_owner: current_user,
        user_uploaded: current_user
      )
      picture.groups << @group

      begin
        errors << picture.errors.full_messages unless picture.save
      rescue => e
        exceptions << e
      end
    end

    raise exceptions.first if exceptions.any?
    flash[:error] = errors.join(". ") if errors.any?
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
