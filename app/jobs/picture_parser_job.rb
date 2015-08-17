class PictureParserJob < ActiveJob::Base
  def perform(picture_id, image_path)
    picture = FamilyGallery::Picture.find(picture_id)
    picture.parse_picture_info(path: image_path)
  end
end
