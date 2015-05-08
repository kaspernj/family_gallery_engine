class AddUserOwnerToGroups < ActiveRecord::Migration
  def change
    add_column :family_gallery_groups, :user_owner_id, :integer, after: :id
    add_index :family_gallery_groups, :user_owner_id
  end
end
