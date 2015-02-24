module FamilyGallery::BaseFamilyGalleryController
  def current_ability
    @current_ability ||= FamilyGallery::Ability.new(current_user)
  end

  def current_user
    current_family_gallery_user
  end
end
