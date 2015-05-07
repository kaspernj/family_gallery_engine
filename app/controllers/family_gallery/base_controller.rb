class FamilyGallery::BaseController < ActionController::Base
  layout "family_gallery/application"
  include FamilyGallery::BaseFamilyGalleryController

  before_filter :set_locale

private

  def set_locale
    session[:locale] ||= I18n.default_locale

    if session[:locale]
      I18n.locale = session[:locale]
    end
  end
end
