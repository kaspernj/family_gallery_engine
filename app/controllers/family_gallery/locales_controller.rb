class FamilyGallery::LocalesController < FamilyGallery::BaseController
  def new
  end

  def create
    I18n.locale = params[:locale]
    session[:locale] = I18n.locale

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { render json: {success: true} }
    end
  end
end
