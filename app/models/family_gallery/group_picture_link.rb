class FamilyGallery::GroupPictureLink < ActiveRecord::Base
  belongs_to :group
  belongs_to :picture

  validates_presence_of :groups, :picture
  validates_uniqueness_of :picture_id, scope: :group_id
end
