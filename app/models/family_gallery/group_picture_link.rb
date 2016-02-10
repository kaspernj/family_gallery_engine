class FamilyGallery::GroupPictureLink < ActiveRecord::Base
  belongs_to :group
  belongs_to :picture

  validates :group, presence: true
  validates :picture, presence: true, unless: :new_record? # If created as a nested resource.
  validates :picture_id, uniqueness: {scope: :group_id}
end
