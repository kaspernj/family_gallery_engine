class FamilyGallery::WelcomeController < FamilyGallery::BaseController
  def index
    @groups = FamilyGallery::Group.ordered_by_latest_update.limit(25).select { |group| can?(:show, group) }
  end
end
