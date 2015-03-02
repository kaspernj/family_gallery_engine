class FamilyGallery::UserTaggingsController < FamilyGallery::ResourcesController
  load_and_authorize_resource

  before_filter :set_picture

  def create
    @user_tagging.picture = @picture
    @user_tagging.tagged_by = current_user
    @user_tagging.assign_attributes(resource_params)

    if @user_tagging.save
      flash[:notice] = t(".tagging_was_saved")
      redirect_to @picture
    else
      flash[:error] = @user_tagging.errors.full_messages.join(". ")
      render :new
    end
  end

  def destroy
    unless @user_tagging.destroy
      flash[:error] = @user_tagging.errors.full_messages.join(". ")
    end

    redirect_to @picture
  end

private

  def set_picture
    @picture = FamilyGallery::Picture.find(params[:picture_id])
    @width = 1000
    @height = @picture.height_for_width(1000)

    authorize! :edit, @picture
  end

  def resource_params
    params.require(:user_tagging).permit(:user_id, :position_top, :position_left)
  end
end
