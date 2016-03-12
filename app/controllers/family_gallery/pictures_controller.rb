class FamilyGallery::PicturesController < FamilyGallery::ResourcesController
  load_and_authorize_resource :group, class: "FamilyGallery::Group"

  def show
    @sizes = {
      small: {
        size: @picture.smartsize(600),
        smartsize: 600,
        url: view_context.rails_imager_p(@picture.image_to_use, maxwidth: 1200, maxheight: 1200)
      },
      big: {
        size: @picture.smartsize(1100),
        smartsize: 1100,
        url: view_context.rails_imager_p(@picture.image_to_use, maxwidth: 2200, maxheight: 2200)
      }
    }

    return unless @group

    @previous_picture = @picture.previous_picture_in_group(@group)
    @next_picture = @picture.next_picture_in_group(@group)
  end

  def rotate
    @picture.rotate(params[:degrees].to_f)
    redirect_to :back
  end

private

  def after_assign
    resource_instance.user_uploaded = current_user
    resource_instance.user_owner = current_user
    resource_instance.groups << @group if @group
  end

  def resource_params
    params.require(:picture).permit(:title, :description, :image, :taken_at)
  end
end
