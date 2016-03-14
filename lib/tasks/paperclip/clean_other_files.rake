namespace :paperclip do
  task "clean_other_files" => :environment do
    puts "Running"

    Rails.application.eager_load!

    FamilyGallery::Picture.find(2)

    puts "Going thorugh descendants"

    ActiveRecord::Base.descendants.each do |klass|
      puts "Class: #{klass}"

      Paperclip::AttachmentRegistry.names_for(klass).each do |*args|
        puts "Args: #{args}"
      end
    end
  end
end
