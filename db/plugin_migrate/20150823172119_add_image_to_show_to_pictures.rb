class AddImageToShowToPictures < ActiveRecord::Migration
  def change
    add_attachment :family_gallery_pictures, :image_to_show
  end
end
