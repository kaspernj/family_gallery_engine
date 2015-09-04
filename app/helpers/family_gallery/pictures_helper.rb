module FamilyGallery::PicturesHelper
  def picture_image_tag(picture, args = {})
    if group = args.delete(:group)
      link_object = [group, picture]
    else
      link_object = picture
    end

    size = args[:size].presence || 200
    crop_size = size * 2

    rounded_corners_size = (crop_size * 0.05).to_i
    picture_url = rails_imager_p(picture.image_to_use, smartsize: crop_size, rounded_corners: rounded_corners_size)
    width_and_height = picture.smartsize(size)
    image_args = {alt: picture.title_with_fallback, class: "picture-image", width: width_and_height[:width], height: width_and_height[:height]}

    return link_to image_tag(picture_url, image_args), link_object
  end
end
