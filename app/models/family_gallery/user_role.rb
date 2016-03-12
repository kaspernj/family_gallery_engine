class FamilyGallery::UserRole < ActiveRecord::Base
  belongs_to :user

  validates :role, uniqueness: {scope: :user_id}
  validates :role, :user, presence: true

  def self.translated_roles
    {
      t(".administrator") => "administrator"
    }
  end

  def translated_role
    FamilyGallery::UserRole.translated_roles.each do |translation, role_i|
      return translation if role_i == role
    end

    raise "No such role: #{role}"
  end
end
