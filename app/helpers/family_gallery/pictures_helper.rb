module FamilyGallery::PicturesHelper
  def picture_image_tag(picture, args = {})
    image_args = {alt: picture.title}.merge(args)
    link_to(image_tag(picture.image.url, image_args), picture)
  end
end
