class FamilyGallery::UserRole < ActiveRecord::Base
  belongs_to :user

  validates :role, uniqueness: {scope: :user_id}
  validates :role, :user, presence: true

  def self.role_options
    {
      t(".administrator") => "administrator"
    }
  end
end
