class FamilyGallery::PicturesController < FamilyGallery::ResourcesController
  before_filter :set_group

  def show
    if view_context.agent_mobile?
      @smartsize = 350
      @width_and_height = @picture.smartsize(@smartsize)
      @picture_url = view_context.rails_imager_p(@picture.image, smartsize: 700, rounded_corners: (350 * 0.05).to_i)
    else
      @smartsize = 800
      @width_and_height = @picture.smartsize(@smartsize)
      @picture_url = view_context.rails_imager_p(@picture.image, smartsize: 1600)
    end

    @width = @width_and_height[:width]
    @height = @width_and_height[:height]

    if @group
      @previous_picture = @picture.previous_picture_in_group(@group)
      @next_picture = @picture.next_picture_in_group(@group)
    end
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
