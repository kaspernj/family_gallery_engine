class FamilyGallery::Group < ActiveRecord::Base
  translates :name, :description # , fallbacks_for_empty_translations: true

  belongs_to :user_owner, class_name: "User"

  has_many :group_picture_links, dependent: :destroy
  has_many :pictures, through: :group_picture_links

  scope :ordered_by_latest_update, -> { joins(:pictures).order("family_gallery_pictures.updated_at DESC").group("family_gallery_groups.id") }

  def set_dates_from_pictures
    lowest_date_picture = pictures.where.not(taken_at: nil).order(:taken_at).first
    highest_date_picture = pictures.where.not(taken_at: nil).order(:taken_at).last

    changes = {}
    changes[:date_from] = lowest_date_picture.taken_at if lowest_date_picture
    changes[:date_to] = highest_date_picture.taken_at if highest_date_picture

    update_attributes!(changes) if changes.any?
  end
end
