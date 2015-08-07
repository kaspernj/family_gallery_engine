class FamilyGallery::Picture < ActiveRecord::Base
  translates :title, :description, fallbacks_for_empty_translations: true

  has_many :group_picture_links, dependent: :destroy
  has_many :groups, through: :group_picture_links
  has_many :user_taggings, dependent: :destroy
  has_many :tagged_users, through: :user_taggings, source: :user

  belongs_to :user_owner, class_name: "User"
  belongs_to :user_uploaded, class_name: "User"

  has_attached_file :image, style: {medium: "900x900", thumb: "120x120"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates_presence_of :user_owner, :image

  after_create :parse_exif

  def width_for_height(new_height)
    return (width.to_f / (height.to_f / new_height.to_f)).to_i
  end

  def height_for_width(new_width)
    return (height.to_f / (width.to_f / new_width.to_f)).to_i
  end

  def smartsize(size)
    if height > width
      return {width: width_for_height(size), height: size}
    else
      return {width: size, height: height_for_width(size)}
    end
  end

  def next_picture_in_group(group)
    group.pictures
      .where("family_gallery_pictures.id > ?", id)
      .order(:id)
      .first
  end

  def previous_picture_in_group(group)
    group.pictures
      .where("family_gallery_pictures.id < ?", id)
      .order(:id)
      .reverse_order
      .first
  end

  def location?
    latitude? && longitude?
  end

  def title_with_fallback
    return title if title.present?
    return title_no_in_group if groups.count == 1
    return t('.picture_with_id', id: id)
  end

  def title_no_in_group
    group = groups.first

    count = 0
    group.pictures.select(:id).order(:id).each do |picture|
      count += 1
      break if picture.id == id
    end

    return t('.no_in_group', count: count, group_name: group.name)
  end

private

  def parse_exif
    raise "No image was given" unless image.present?

    require "exifr"
    exif = EXIFR::JPEG.new(image.queued_for_write[:original].path)

    updates = {
      width: exif.width,
      height: exif.height
    }

    if exif.date_time
      updates[:taken_at] = exif.date_time
    elsif exif.date_time_digitized
      updates[:taken_at] = exif.date_time_digitized
    elsif exif.date_time_original
      updates[:taken_at] = exif.date_time_original
    end

    if exif.gps
      updates[:latitude] = exif.gps.latitude if exif.gps.latitude.present?
      updates[:longitude] = exif.gps.longitude if exif.gps.longitude.present?
    end

    update_attributes!(updates)
  end
end
