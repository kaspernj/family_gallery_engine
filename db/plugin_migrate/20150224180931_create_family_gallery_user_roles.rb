class CreateFamilyGalleryUserRoles < ActiveRecord::Migration
  def change
    create_table :family_gallery_user_roles do |t|
      t.belongs_to :user
      t.string :role
      t.timestamps
    end

    add_index :family_gallery_user_roles, :user_id
    add_index :family_gallery_user_roles, [:user_id, :role], unique: true
  end
end
