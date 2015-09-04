class FamilyGallery::PicturesController < FamilyGallery::ResourcesController
  before_filter :set_group

  def show
    @sizes = {
      small: {
        size: @picture.smartsize(600),
        smartsize: 600,
        url: view_context.rails_imager_p(@picture.image_to_use, smartsize: 1200, rounded_corners: (350 * 0.05).to_i)
      },
      big: {
        size: @picture.smartsize(1100),
        smartsize: 1100,
        url: view_context.rails_imager_p(@picture.image_to_use, smartsize: 2200, rounded_corners: (1100 * 0.05).to_i)
      }
    }

    @width = @sizes[:big][:size][:width]
    @height = @sizes[:big][:size][:height]

    if @group
      @previous_picture = @picture.previous_picture_in_group(@group)
      @next_picture = @picture.next_picture_in_group(@group)
    end
  end

  def rotate
    @picture.rotate(params[:degrees].to_f)
    redirect_to :back
  end

private

  def set_group
    @group = FamilyGallery::Group.find(params[:group_id]) if params[:group_id]
  end

  def after_assign
    resource_instance.user_uploaded = current_user
    resource_instance.user_owner = current_user
    resource_instance.groups << FamilyGallery::Group.find(params[:group_id]) if params[:group_id].present?
  end

  def resource_params
    params.require(:picture).permit(:title, :description, :image, :taken_at)
  end
end
