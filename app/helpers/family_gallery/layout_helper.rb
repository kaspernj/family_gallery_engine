module FamilyGallery::LayoutHelper
  def header_title
    @header_title ||= content_for(:header_title).to_s
  end
end
