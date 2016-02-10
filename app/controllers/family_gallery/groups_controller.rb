class FamilyGallery::GroupsController < FamilyGallery::BaseController
  load_and_authorize_resource

  def index
    @ransack_values = params[:q] || {}
    @ransack = FamilyGallery::Group.ransack(@ransack_values)

    @groups = @ransack
      .result
      .accessible_by(current_ability)
      .page(params[:page])

    if @ransack_values[:name_cont].present?
      @groups = @groups.with_translations.where("family_gallery_group_translations.name LIKE ?", "%#{@ransack_values.fetch(:name_cont)}%")
    end

    if @ransack_values[:description_cont].present?
      @groups = @groups.with_translations.where("family_gallery_group_translations.description LIKE ?", "%#{@ransack_values.fetch(:description_cont)}%")
    end

    @groups = @groups.order(:id) unless @ransack_values[:s]
  end

  def show
    @pictures = @group.pictures.page(params[:page])
  end

  def new
  end

  def create
    if @group.save
      redirect_to @group
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update_attributes(group_params)
      redirect_to @group
    else
      render :edit
    end
  end

  def destroy
    if @group.destroy
      redirect_to groups_url
    else
      flash[:error] = @group.errors.full_messages.join(". ")
      redirect_to @group
    end
  end

  def set_dates_from_pictures
    @group.set_dates_from_pictures
    redirect_to @group
  end

private

  def group_params
    params.require(:group).permit(:name, :description, :date_from, :date_to)
  end

  helper_method :groups_of_pictures
  def groups_of_pictures
    batch_size = 6

    @pictures.to_a.each_slice(batch_size) do |pictures|
      yield pictures
    end
  end
end
