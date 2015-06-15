class FamilyGallery::WelcomeController < FamilyGallery::BaseController
  def index
    @groups = FamilyGallery::Group
      .accessible_by(current_ability)
      .ordered_by_latest_update
      .limit(25)
  end
end
