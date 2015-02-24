class CreateFamilyGalleryGroups < ActiveRecord::Migration
  def up
    create_table :family_gallery_groups do |t|
      t.timestamps
    end

    FamilyGallery::Group.create_translation_table! name: :string, description: :text
  end

  def down
    drop_table :family_gallery_groups
    FamilyGallery::Group.drop_translation_table!
  end
end
