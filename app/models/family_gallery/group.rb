module FamilyGallery
  class Group < ActiveRecord::Base
    translates :name, :description

    has_many :group_picture_links, dependent: :destroy
    has_many :pictures, through: :group_picture_links
  end
end
