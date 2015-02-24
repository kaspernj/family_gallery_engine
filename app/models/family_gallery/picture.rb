module FamilyGallery
  class Picture < ActiveRecord::Base
    translates :title, :description

    has_many :group_picture_links, dependent: :destroy
    has_many :groups, through: :group_picture_links

    belongs_to :user_owner, class_name: "User"
    belongs_to :user_uploaded, class_name: "User"

    has_attached_file :image, style: {medium: "900x900", thumb: "120x120"}
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  end
end
