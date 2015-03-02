class FamilyGallery::Group < ActiveRecord::Base
  translates :name, :description

  has_many :group_picture_links, dependent: :destroy
  has_many :pictures, through: :group_picture_links

  scope :ordered_by_latest_update, -> { joins(:pictures).order("family_gallery_pictures.updated_at DESC").group("family_gallery_groups.id") }
end
