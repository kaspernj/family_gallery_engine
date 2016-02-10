class FamilyGallery::BaseController < ActionController::Base
  layout "family_gallery/application"

  include AwesomeTranslations::ControllerTranslateFunctionality
  include FamilyGallery::BaseFamilyGalleryController

  before_filter :set_locale

private

  def set_locale
    session[:locale] ||= I18n.default_locale

    I18n.locale = session[:locale] if session[:locale].present?
  end
end
