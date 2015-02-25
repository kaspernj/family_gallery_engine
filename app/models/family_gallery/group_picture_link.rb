class FamilyGallery::GroupPictureLink < ActiveRecord::Base
  belongs_to :group
  belongs_to :picture

  validates_presence_of :group
  validates_presence_of :picture, unless: :new_record? # If created as a nested resource.
  validates_uniqueness_of :picture_id, scope: :group_id
end
