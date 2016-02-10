class FamilyGallery::UserTagging < ActiveRecord::Base
  belongs_to :picture
  belongs_to :tagged_by, class_name: "User"
  belongs_to :user

  validates_presence_of :picture, :user, :tagged_by, :position_left, :position_top
  validates_uniqueness_of :user, scope: :picture

  scope :ordered, -> { joins(:user).order("family_gallery_users.first_name, family_gallery_users.last_name, family_gallery_users.email") }

  def left_for_width(width)
    (width * (position_left.to_f / 100)).to_i
  end

  def left_percentage
    (position_left.to_f / picture.width.to_f) * 100
  end

  def top_for_height(height)
    (height * (position_top.to_f / 100)).to_i
  end

  def top_percentage
    (position_top.to_f / picture.height.to_f) * 100
  end
end
