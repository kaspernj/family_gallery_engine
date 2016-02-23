class FamilyGallery::UserTagging < ActiveRecord::Base
  belongs_to :picture
  belongs_to :tagged_by, class_name: "User"
  belongs_to :user

  validates :picture, :user, :tagged_by, :position_left, :position_top, presence: true
  validates :user, uniqueness: {scope: :picture}

  scope :ordered, -> { joins(:user).order("family_gallery_users.first_name, family_gallery_users.last_name, family_gallery_users.email") }
end
