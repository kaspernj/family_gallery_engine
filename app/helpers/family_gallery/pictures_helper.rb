module FamilyGallery::PicturesHelper
  def picture_image_tag(picture, args = {})
    image_args = {alt: picture.title, class: "picture-image"}.merge(args)

    if args[:group]
      link_object = [args[:group], picture]
    else
      link_object = picture
    end

    link_to(image_tag(picture.image.url, image_args), link_object)
  end
end
