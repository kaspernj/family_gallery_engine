class CreateFamilyGalleryPictures < ActiveRecord::Migration
  def up
    create_table :family_gallery_pictures do |t|
      t.integer :user_owner_id
      t.integer :user_uploaded_id
      t.datetime :taken_at
      t.integer :width
      t.integer :height
      t.decimal :latitude, precision: 10, scale: 8
      t.decimal :longitude, precision: 10, scale: 8
      t.timestamps
    end

    add_index :family_gallery_pictures, :user_owner_id
    add_index :family_gallery_pictures, :user_uploaded_id
    add_index :family_gallery_pictures, :taken_at
    add_index :family_gallery_pictures, :latitude
    add_index :family_gallery_pictures, :longitude

    add_attachment :family_gallery_pictures, :image

    FamilyGallery::Picture.create_translation_table! title: :string, description: :text
  end

  def down
    drop_table :family_gallery_pictures
    FamilyGallery::Picture.drop_translation_table!
  end
end
