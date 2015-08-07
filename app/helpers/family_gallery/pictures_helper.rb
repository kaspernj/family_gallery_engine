module FamilyGallery::PicturesHelper
  def picture_image_tag(picture, args = {})
    image_args = {alt: picture.title, class: "picture-image"}.merge(args)

    if args[:group]
      link_object = [args[:group], picture]
    else
      link_object = picture
    end

    width = image_args[:width].presence || 200
    width *= 2

    picture_url = rails_imager_p(picture.image, maxwidth: width)

    link_to(image_tag(picture_url, image_args), link_object)
  end
end
