class CreateFamilyGalleryGroupPictureLinks < ActiveRecord::Migration
  def change
    create_table :family_gallery_group_picture_links do |t|
      t.belongs_to :group
      t.belongs_to :picture
      t.timestamps
    end

    add_index :family_gallery_group_picture_links, :group_id
    add_index :family_gallery_group_picture_links, :picture_id
    add_index :family_gallery_group_picture_links, [:group_id, :picture_id], unique: true, name: "unique_group_and_picture"
  end
end
