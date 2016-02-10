class AddMissingForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :family_gallery_group_picture_links, :family_gallery_pictures, column: "picture_id"
    add_foreign_key :family_gallery_group_translations, :family_gallery_groups
    add_foreign_key :family_gallery_groups, :family_gallery_users, column: "user_owner_id"
    add_foreign_key :family_gallery_picture_translations, :family_gallery_pictures
    add_foreign_key :family_gallery_pictures, :family_gallery_users, column: "user_owner_id"
    add_foreign_key :family_gallery_pictures, :family_gallery_users, column: "user_uploaded_id"
    add_foreign_key :family_gallery_user_roles, :family_gallery_users, column: "user_id"
    add_foreign_key :family_gallery_user_taggings, :family_gallery_pictures, column: "picture_id"
    add_foreign_key :family_gallery_user_taggings, :family_gallery_users, column: "user_id"
    add_foreign_key :family_gallery_user_taggings, :family_gallery_users, column: "tagged_by_id"
  end
end
