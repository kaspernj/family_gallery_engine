class FamilyGallery::PicturesController < FamilyGallery::ResourcesController
  before_filter :set_group

  def show
    if view_context.agent_mobile?
      @width = 350
      @picture_url = view_context.rails_imager_p(@picture.image, maxwidth: 800, rounded_corners: (350 * 0.05).to_i)
    else
      @width = 800
      @picture_url = view_context.rails_imager_p(@picture.image, maxwidth: 1600)
    end

    @height = @picture.height_for_width(@width)

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
    params.require(:picture).permit(:title, :description, :image)
  end
end
