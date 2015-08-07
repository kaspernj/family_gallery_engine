module FamilyGallery::PicturesHelper
  def picture_image_tag(picture, args = {})
    if group = args.delete(:group)
      link_object = [group, picture]
    else
      link_object = picture
    end

    image_args = {alt: picture.title, class: "picture-image"}.merge(args)

    width = args[:width].presence || 200
    width *= 2

    rounded_corners_size = (width * 0.05).to_i

    picture_url = rails_imager_p(picture.image, maxwidth: width, rounded_corners: rounded_corners_size)

    link_to(image_tag(picture_url, image_args), link_object)
  end
end
