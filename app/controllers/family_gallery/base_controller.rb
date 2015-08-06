class FamilyGallery::BaseController < ActionController::Base
  layout "family_gallery/application"

  include AwesomeTranslations::ControllerTranslateFunctionality
  include FamilyGallery::BaseFamilyGalleryController
  include LightMobile::DynamicRenderer

  before_filter :set_locale
  before_filter :debug_output

private

  def debug_output
    logger.warn "AgentMobile: #{view_context.agent_mobile?}"
    logger.warn "AgentBrowser: #{view_context.agent_browser}"
    logger.warn "UserAgent: #{view_context.request.user_agent}"
  end

  def set_locale
    session[:locale] ||= I18n.default_locale

    if session[:locale]
      I18n.locale = session[:locale]
    end
  end
end
