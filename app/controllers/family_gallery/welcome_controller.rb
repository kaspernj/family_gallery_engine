class FamilyGallery::WelcomeController < FamilyGallery::BaseController
  def index
    @groups = FamilyGallery::Group
      .accessible_by(current_ability)
      .ordered_by_latest_update
      .limit(15)
      .page(params[:page])
  end
end
