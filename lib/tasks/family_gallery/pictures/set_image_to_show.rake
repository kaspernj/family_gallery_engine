namespace :family_gallery do
  namespace :pictures do
    task "set_image_to_show" => :environment do
      pictures = FamilyGallery::Picture.where("family_gallery_pictures.image_to_show_file_name IS NULL")
      pictures.find_each do |picture|
        picture.image_to_show = picture.image
        picture.save!
      end
    end
  end
end
