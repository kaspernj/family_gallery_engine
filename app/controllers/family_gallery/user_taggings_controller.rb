class FamilyGallery::UserTaggingsController < FamilyGallery::BaseController
  before_filter :set_picture

  load_and_authorize_resource
  skip_authorize_resource only: :new

  def create
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

    if view_context.agent_mobile?
      @width = 300
    else
      @width = 1000
    end

    @height = @picture.height_for_width(@width)

    if action_name == "create"
      @user_tagging = @picture.user_taggings.new
      @user_tagging.tagged_by = current_user
      @user_tagging.assign_attributes(user_tagging_params)
    end
  end

  def user_tagging_params
    params.require(:user_tagging).permit(:user_id, :position_top, :position_left)
  end
end
