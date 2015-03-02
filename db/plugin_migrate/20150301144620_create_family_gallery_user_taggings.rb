class CreateFamilyGalleryUserTaggings < ActiveRecord::Migration
  def change
    create_table :family_gallery_user_taggings do |t|
      t.belongs_to :picture
      t.belongs_to :user
      t.belongs_to :tagged_by
      t.decimal :position_top, precision: 10, scale: 2
      t.decimal :position_left, precision: 10, scale: 2
      t.timestamps
    end

    add_index :family_gallery_user_taggings, :picture_id
    add_index :family_gallery_user_taggings, :user_id
    add_index :family_gallery_user_taggings, :tagged_by_id
  end
end
