class CreateFamilyGalleryPictures < ActiveRecord::Migration
  def up
    create_table :family_gallery_pictures do |t|
      t.integer :user_owner_id
      t.integer :user_uploaded_id
      t.timestamps
    end

    add_index :family_gallery_pictures, :group_id
    add_attachment :family_gallery_pictures, :image

    FamilyGallery::Picture.create_translation_table! title: :string, description: :text
  end

  def down
    drop_table :family_gallery_pictures
    FamilyGallery::Picture.drop_translation_table!
  end
end
