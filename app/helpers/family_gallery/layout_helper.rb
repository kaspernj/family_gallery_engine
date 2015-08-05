module FamilyGallery::LayoutHelper
  include LightMobile::ApplicationHelper

  def header_title
    @header_title ||= content_for(:header_title).to_s
  end
end
