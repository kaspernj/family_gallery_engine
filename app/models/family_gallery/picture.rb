class FamilyGallery::Picture < ActiveRecord::Base
  translates :title, :description, fallbacks_for_empty_translations: true

  has_many :group_picture_links, dependent: :destroy
  has_many :groups, through: :group_picture_links
  has_many :user_taggings, dependent: :destroy
  has_many :tagged_users, through: :user_taggings, source: :user

  belongs_to :user_owner, class_name: "User"
  belongs_to :user_uploaded, class_name: "User"

  has_attached_file :image
  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\Z}

  has_attached_file :image_to_show, styles: {large: ["2200x2200>", :jpg, 90], medium: ["1200x1200>", :jpg, 90], thumbnail: ["200x200>", :jpg, 90]}
  validates_attachment_content_type :image_to_show, content_type: %r{\Aimage/.*\Z}

  validates :user_owner, :image, presence: true
  after_create :queue_parse_picture_info
  before_save :set_image_to_show_if_changed

  def thumbnail_ordered_sizes
    [:large, :medium, :thumbnail]
  end

  def image_to_show_from_size(size)
    choose = nil
    thumbnail_ordered_sizes.reverse.each do |size_i|
      choose = true if size == size_i

      next unless choose

      image_to_choose = image_to_show.url(size_i)
      return image_to_choose if image_to_choose.present?
    end

    raise "Unknown size: #{size}"
  end

  def width_for_height(new_height)
    (width.to_f / (height.to_f / new_height.to_f)).to_i
  end

  def height_for_width(new_width)
    (height.to_f / (width.to_f / new_width.to_f)).to_i
  end

  def smartsize(size)
    if height > width
      {width: width_for_height(size), height: size}
    else
      {width: size, height: height_for_width(size)}
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
    t(".picture_with_id", id: id)
  end

  def title_no_in_group
    group = groups.first

    count = 0
    group.pictures.select(:id).order(:id).each do |picture|
      count += 1
      break if picture.id == id
    end

    t(".no_in_group", count: count, group_name: group.name)
  end

  def parse_picture_info(args = {})
    @image_path_to_use = args[:path]

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

  def image_to_use
    return image_to_show if image_to_show.present?
    image
  end

  def rotate(degrees)
    magick_image = ::Magick::Image.read(image_to_use.path).first
    magick_image.rotate!(degrees)

    tempfile = Tempfile.new(["family_gallery_picture_rotate", ".png"])
    magick_image.write(tempfile.path)
    tempfile.close

    File.open(tempfile.path) do |fp|
      update_attributes!(
        image_to_show: fp,
        width: magick_image.columns,
        height: magick_image.rows
      )
    end

    magick_image.destroy!
    parse_rmagick

    true
  end

private

  # This helps reads from special paths which is due to Paperclip may store files in temp locations
  def image_path_to_use(args = {})
    return @image_path_to_use if @image_path_to_use && File.exist?(@image_path_to_use)

    path = image.queued_for_write[:original].try(:path)
    return path if path && File.exist?(path)

    path = image.path if args[:original]
    return path if path && File.exist?(path)

    path = image_to_use.path
    return path if path && File.exist?(path)

    raise "Couldn't find image"
  end

  def queue_parse_picture_info
    PictureParserJob.new(id, image_path_to_use).enqueue
  end

  def parse_exif
    raise "No image was given" unless image.present?

    require "exifr"
    exif = EXIFR::JPEG.new(image_path_to_use(original: true))

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
    image = ::Magick::Image.read(image_path_to_use).first

    update_attributes!(
      width: image.columns,
      height: image.rows
    )
  end

  def set_image_to_show_if_changed
    self.image_to_show = image if image_updated_at_changed?
  end
end
