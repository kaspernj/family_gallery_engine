class FamilyGallery::User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable

  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :owned_groups, class_name: "Group", foreign_key: "user_owner_id", dependent: :restrict_with_error
  has_many :owned_pictures, class_name: "Picture", foreign_key: "user_owner_id", dependent: :restrict_with_error
  has_many :pictures_tagged_on, through: :user_taggings, source: :picture
  has_many :user_roles, dependent: :destroy
  has_many :user_taggings, dependent: :destroy
  has_many :user_taggings_created, class_name: "UserTagging"
  has_many :uploaded_pictures, class_name: "Picture", foreign_key: "user_uploaded_id", dependent: :restrict_with_error

  scope :ordered, -> { order("family_gallery_users.first_name, family_gallery_users.last_name, family_gallery_users.email") }

  def name
    name = "#{first_name}" # Needs to be a new string.
    name << " #{last_name}" if last_name?

    name = email unless name.present?

    return name
  end
end
