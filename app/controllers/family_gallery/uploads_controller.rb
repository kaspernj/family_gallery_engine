class FamilyGallery::UploadsController < FamilyGallery::BaseController
  before_filter :authorize_uploads
  before_filter :set_group

  def index
    @uploads = FamilyGallery::Picture.all

    respond_to do |format|
      format.html
      format.json { render json: @uploads.map(&:to_jq_upload) }
    end
  end

  def show
    @upload = FamilyGallery::Picture.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @upload }
    end
  end

  def new
    @upload = FamilyGallery::Picture.new

    respond_to do |format|
      format.html
      format.json { render json: @upload }
    end
  end

  def edit
    @upload = FamilyGallery::Picture.find(params[:id])
  end

  def create
    params[:picture][:image].each do |image|
      @upload = FamilyGallery::Picture.create!(
        groups: [@group],
        image: image,
        user_owner: current_user,
        user_uploaded: current_user
      )
    end

    respond_to do |format|
      format.html { render json: [@upload.to_jq_upload].to_json, content_type: "text/html", layout: false }
      format.json { render json: {files: [@upload.to_jq_upload]}, status: :created, location: @upload }
    end
  rescue => e
    respond_to do |format|
      format.html { render action: "new" }
      format.json { render json: e.message, status: :unprocessable_entity }
    end

    puts e.inspect
    puts e.backtrace
  end

  def update
    @upload = FamilyGallery::Picture.find(params[:id])

    respond_to do |format|
      if @upload.update_attributes(resource_params)
        format.html { redirect_to @upload, notice: "FamilyGallery::Picture was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @upload = FamilyGallery::Picture.find(params[:id])
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end

private

  def authorize_uploads
    authorize! :create, FamilyGallery::Picture
  end

  def set_group
    @group = FamilyGallery::Group.find(params[:group_id])
  end
end
