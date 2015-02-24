module FamilyGallery
  class Group < ActiveRecord::Base
    translates :name, :description
  end
end
