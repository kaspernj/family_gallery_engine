namespace :family_gallery do
  namespace :pictures do
    task "set_image_to_show_for_pictures" => :environment do
      pictures = FamilyGallery::Picture.all

      require "progress_bar"
      progress_bar = ProgressBar.new(pictures.count)

      pictures.find_each do |picture|
        picture.update_attributes!(image_to_show: picture.image)
        progress_bar.increment!
      end
    end
  end
end
