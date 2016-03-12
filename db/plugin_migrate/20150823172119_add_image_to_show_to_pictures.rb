class AddImageToShowToPictures < ActiveRecord::Migration
  def up
    add_attachment :family_gallery_pictures, :image_to_show unless column_exists? :family_gallery_pictures, :image_to_show_file_name
  end

  def down
    remove_attachment :family_gallery_pictures, :image_to_show
  end
end
