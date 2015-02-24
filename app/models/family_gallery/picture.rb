module FamilyGallery
  class Picture < ActiveRecord::Base
    translates :title, :description
  end
end
