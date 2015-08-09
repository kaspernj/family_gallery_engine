class AddDateFromAndDateToToGroups < ActiveRecord::Migration
  def change
    add_column :family_gallery_groups, :date_from, :datetime, after: :user_owner_id
    add_column :family_gallery_groups, :date_to, :datetime, after: :date_from

    add_index :family_gallery_groups, :date_from
    add_index :family_gallery_groups, :date_to
  end
end
