module FamilyGallery::ApplicationHelper
  include AwesomeTranslations::ApplicationHelper
  include BootstrapBuilders::ApplicationHelper
  include RailsImager::ImagesHelper
  include SimpleFormRansackHelper

  def menu_link(*args, &blk)
    content_tag :li do
      link_to(*args, &blk)
    end
  end
end
