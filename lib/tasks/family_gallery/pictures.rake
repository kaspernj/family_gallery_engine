namespace :family_gallery do
  namespace :pictures do
    task "update_thumbnails" => :environment do
      pictures = FamilyGallery::Picture.all

      require "progress_bar"
      progress_bar = ProgressBar.new(pictures.count)

      pictures.find_each do |picture|
        if picture.image_to_show.present?
          picture.update_attributes!(image_to_show: picture.image)
        else
          picture.reprocess!
        end

        progress_bar.increment!
      end
    end
  end
end
