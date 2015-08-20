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

  after_create :queue_parse_picture_info

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

  def parse_picture_info(args = {})
    @image_path = args[:path]

    begin
      parse_exif
    rescue EXIFR::MalformedJPEG
      # Picture does not contain any EXIF data - read sizes with RMagick instead
      parse_rmagick
    end
  end

  def to_jq_upload
    {
      "name" => image_file_name,
      "size" => image_file_size,
      "url" => image.url(:original),
      "delete_url" => FamilyGallery::Engine.routes.url_helpers.group_uploads_path(groups.first, self),
      "delete_type" => "DELETE"
    }
  end

private

  # This helps reads from special paths which is due to Paperclip may store files in temp locations
  def image_path
    return @image_path if @image_path && File.exists?(@image_path)

    path = image.queued_for_write[:original].path
    return path if File.exists?(path)

    path = image.path
    return path if File.exists?(path)

    raise "Couldn't find image"
  end

  def queue_parse_picture_info
    PictureParserJob.new(id, image_path).enqueue
  end

  def parse_exif
    raise "No image was given" unless image.present?

    require "exifr"
    exif = EXIFR::JPEG.new(image_path)

    updates = {
      width: exif.width,
      height: exif.height
    }

    unless taken_at?
      if exif.date_time
        updates[:taken_at] = exif.date_time
      elsif exif.date_time_digitized
        updates[:taken_at] = exif.date_time_digitized
      elsif exif.date_time_original
        updates[:taken_at] = exif.date_time_original
      end
    end

    if exif.gps
      updates[:latitude] = exif.gps.latitude if exif.gps.latitude.present?
      updates[:longitude] = exif.gps.longitude if exif.gps.longitude.present?
    end

    update_attributes!(updates)
  end

  def parse_rmagick
    image = ::Magick::Image.read(image_path).first

    update_attributes!(
      width: image.columns,
      height: image.rows
    )
  end
end
