class FamilyGallery::GroupsController < FamilyGallery::BaseController
  load_and_authorize_resource

  def index
    @ransack_values = params[:q] || {}
    @ransack = FamilyGallery::Group.ransack(@ransack_values)

    @groups = @ransack.result
    @groups = @groups.order(:id) unless @ransack_values[:s]
    @groups = @groups.page(params[:page])
    @groups = @groups.select { |group| can?(:show, group) }
  end

  def show
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

private

  def group_params
    params.require(:group).permit(:name, :description)
  end

  helper_method :groups_of_pictures
  def groups_of_pictures
    @group.pictures.find_in_batches(batch_size: 6) do |pictures|
      yield pictures
    end
  end
end
