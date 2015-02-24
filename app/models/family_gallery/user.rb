module FamilyGallery
  class User < ActiveRecord::Base
    devise :database_authenticatable, :recoverable, :rememberable, :trackable

    validates_presence_of :email
    validates_uniqueness_of :email

    has_many :user_roles, dependent: :destroy
    has_many :owned_pictures, class_name: "Picture", foreign_key: "user_owner_id", dependent: :restrict_with_error
    has_many :uploaded_pictures, class_name: "Picture", foreign_key: "user_uploaded_id", dependent: :restrict_with_error
  end
end
