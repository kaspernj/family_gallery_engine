class FamilyGallery::UserRole < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :role
  validates_uniqueness_of :role, scope: :user_id
  validates_presence_of :user
end
