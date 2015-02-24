module FamilyGallery
  class User < ActiveRecord::Base
    devise :database_authenticatable, :recoverable, :rememberable, :trackable

    validates_presence_of :email
    validates_uniqueness_of :email
  end
end
