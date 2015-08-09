module FamilyGallery::LayoutHelper
  include AwesomeTranslations::ApplicationHelper
  include LightMobile::ApplicationHelper
  include RailsImager::ImagesHelper

  def header_title
    @header_title ||= content_for(:header_title).to_s
  end
end
