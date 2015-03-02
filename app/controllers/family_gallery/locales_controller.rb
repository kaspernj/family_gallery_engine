class FamilyGallery::LocalesController < FamilyGallery::BaseController
  def create
    I18n.locale = params[:locale]
    session[:locale] = I18n.locale

    render json: {success: true}
  end
end
